class DatacentersController < ApplicationController
  # GET /datacenters
  # GET /datacenters.json
  load_and_authorize_resource
  def index
    @doubleview = session[:double]
    @datacenters = Datacenter.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @datacenters }
    end
  end

  # GET /datacenters/1
  # GET /datacenters/1.json
  def show
    @doubleview = session[:double]
    if @doubleview
      session[:viewport] = params[:viewport] || 'week'
      @datacenters = Datacenter.all
    else  
      @datacenter = Datacenter.find(params[:id])
    end  
    
    @viewport = session[:viewport]


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @datacenter }
    end
  end

  # GET /datacenters/new
  # GET /datacenters/new.json
  def new
    @datacenter = Datacenter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @datacenter }
    end
  end

  # GET /datacenters/1/edit
  def edit
    @datacenter = Datacenter.find(params[:id])
  end

  # POST /datacenters
  # POST /datacenters.json
  def create
    @datacenter = Datacenter.new(params[:datacenter])

    respond_to do |format|
      if @datacenter.save
        format.html { redirect_to @datacenter, notice: 'Datacenter was successfully created.' }
        format.json { render json: @datacenter, status: :created, location: @datacenter }
      else
        format.html { render action: "new" }
        format.json { render json: @datacenter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /datacenters/1
  # PUT /datacenters/1.json
  def update
    @datacenter = Datacenter.find(params[:id])

    respond_to do |format|
      if @datacenter.update_attributes(params[:datacenter])
        format.html { redirect_to @datacenter, notice: 'Datacenter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @datacenter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datacenters/1
  # DELETE /datacenters/1.json
  def destroy
    @datacenter = Datacenter.find(params[:id])
    @datacenter.destroy

    respond_to do |format|
      format.html { redirect_to datacenters_url }
      format.json { head :no_content }
    end
  end

  def set_viewport

    session[:viewport] = params[:viewport] || 'week'
    respond_to do |format|
      format.html { redirect_to datacenter_url(params) }
    end

  end

  def set_doubleview
      
    session[:doubleview] = params[:double] || nil
    respond_to do |format|
      format.html { redirect_to datacenter_url(params) }
      end
      
  end  
  
  def day_reserve

    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    day = Day.find_by_date(date)
    if day.nil?
      day = Day.create(:date => date);
      day.save
    end
    shift_id = params[:shift] == 'day' ? 1 : 2
    center_id = params[:id] 
    day_collection = day.day_collections.new(:user_id => current_user.id,:status_id => 2, :shift_id => shift_id,:center_id => center_id )
    day_collection.save

    respond_to do |format|
      format.html {  redirect_to datacenter_url(params) }
    end
  end

  def day_confirm
    day_collection = DayCollection.find(params[:coll_id])

    day = day_collection.day
    day_collection.update_attribute(:status_id, 1)
    Thread.new do
      Notifier.shift_confirmation(day_collection).deliver
      ActiveRecord::Base.connection.close
    end  
    respond_to do |format|
      format.html {  redirect_to datacenter_url(params) }
    end
  end

  def day_destroy

    day_collection = DayCollection.find(params[:coll_id])

    day = day_collection.day
    if day_collection.user_id == current_user.id or current_user.admin?
      Thread.new do
        Notifier.shift_destroy(day_collection,current_user).deliver
        ActiveRecord::Base.connection.close
      end
      day_collection.destroy
    end
    respond_to do |format|
      format.html {  redirect_to datacenter_url(params) }
    end

  end
  
  def admin_manage_days

    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @day = Day.find_by_date(date)
    if @day.nil?
      @day = Day.create(:date => date);
    end
    @collections = @day.day_collections.all
    users = User.free_for_shift(@day)

    collections_new = []
    users.each do |user|
      collections_new << @day.day_collections.new(:user_id => user.id, :center_id => params[:id])
    end
    @collections_new = collections_new

    respond_to do |format|
      format.html
    end
    
  end

  def admin_process_days

    users = params[:users_id] ? params[:users_id] : []
    day = Day.find(params[:day_id])
    #update

    if(params[:day_collections])
      DayCollection.transaction do
        params[:day_collections].map do |k,r|
          if(users.include? r[:user_id])
            sql_u = ActiveRecord::Base.send(:sanitize_sql_array,
              ["UPDATE day_collections SET status_id = #{r[:status_id]},shift_id = #{r[:shift_id]},center_id = #{r[:center_id]}
              WHERE day_collections.id = #{r[:id]}"]
            )
            DayCollection.connection.execute(sql_u)
                Thread.new do
                  day_collection = DayCollection.find(r[:id])
                  fake = DayCollection.new(r)
                  Notifier.admin_update_shift(day_collection).deliver unless fake.identical? day_collection
                  ActiveRecord::Base.connection.close
                end
          else
            sql_d = ActiveRecord::Base.send(:sanitize_sql_array,
              ["DELETE FROM day_collections WHERE day_collections.id = #{r[:id]}"]
            )
                Thread.new do
                  Notifier.admin_delete_shift(DayCollection.find(r[:id])).deliver
                  ActiveRecord::Base.connection.close
                end
            DayCollection.connection.execute(sql_d)

          end
        end
      end
    end

    #insert

    if(params[:day_collections_new])
      DayCollection.transaction do
        @collections = []
        params[:day_collections_new].map do |r|
          if(users.include? r[:user_id])
            sql = ActiveRecord::Base.send(:sanitize_sql_array,
             ["INSERT INTO day_collections
             (day_id, shift_id, status_id, user_id, center_id) VALUES
             (#{r[:day_id]}, #{r[:shift_id]}, #{r[:status_id]},#{r[:user_id]},#{r[:center_id]})"]
            )
            DayCollection.connection.execute(sql)
            @collections << DayCollection.where(:day_id => r[:day_id],:user_id => r[:user_id]).first 
          end
        end
      end
        
        Thread.new do  
          @collections.each do |collection|        
            Notifier.admin_create_shift(collection).deliver
            ActiveRecord::Base.connection.close
          end
        end
      end

    respond_to do |format|
        format.html {  redirect_to datacenter_url(date_to_params(day.date)) }
    end
  end


  private
  def date_to_params(date)
    hash = { :year => date.year, :month => date.month  }
    if session[:viewport] == 'week'
      hash.merge(:day => date.day)
    end
    hash
  end

end
