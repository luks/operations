class DatacentersController < ApplicationController
  # GET /datacenters
  # GET /datacenters.json
  load_and_authorize_resource
  def index

    @datacenters = Datacenter.all
    @view = session[:view]
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @datacenters }
    end
  end

  # GET /datacenters/1
  # GET /datacenters/1.json
  def show
    @datacenter = Datacenter.find(params[:id])
    @view = session[:view]

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

  def set_view

    session[:view] = params[:view] || 'week'
    respond_to do |format|
      format.html { redirect_to datacenter_url(params) }
    end

  end
  
  def day_reserve

    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    day = Day.where(:date => date, :center_id => params[:id]).first
    if day.nil?
      day = Day.create(:date => date,:center_id => params[:id]);
      day.save
    end
    shift_id = params[:shift] == 'day' ? 1 : 2

    day_collection = day.day_collections.new(:user_id => current_user.id,:status_id => 2, :shift_id => shift_id )
    day_collection.save

    respond_to do |format|
      format.html {  redirect_to datacenter_url(params) }
    end
  end

  def day_confirm
    day_collection = DayCollection.find(params[:coll_id])
    day = day_collection.day
    day_collection.update_attribute(:status_id, 1)
    respond_to do |format|
      format.html {  redirect_to datacenter_url(params) }
    end
  end

  def day_destroy

    day_collection = DayCollection.find(params[:coll_id])
    day = day_collection.day
    if day_collection.user_id == current_user.id or current_user.admin?
      day_collection.destroy
    end
    respond_to do |format|
      format.html {  redirect_to datacenter_url(params) }
    end

  end
  
  def admin_manage_days

    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @day = Day.where(:date => date, :center_id => params[:id]).first
    if @day.nil?
      @day = Day.create(:date => date, :center_id => params[:id]);
    end
    @collections = @day.day_collections.all
    users = User.free_for_shift(@day)

    collections_new = []
    users.each do |user|
      collections_new << @day.day_collections.new(:user_id => user.id)
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
              ["UPDATE day_collections SET status_id = #{r[:status_id]},shift_id = #{r[:shift_id]}
              WHERE day_collections.id = #{r[:id]}"]
            )
            DayCollection.connection.execute(sql_u)
          else
            sql_d = ActiveRecord::Base.send(:sanitize_sql_array,
              ["DELETE FROM day_collections WHERE day_collections.id = #{r[:id]}"]
            )
            DayCollection.connection.execute(sql_d)
          end
        end
      end
    end

    #insert

    if(params[:day_collections_new])
      DayCollection.transaction do
        params[:day_collections_new].map do |r|
          if(users.include? r[:user_id])
            sql = ActiveRecord::Base.send(:sanitize_sql_array,
             ["INSERT INTO day_collections
             (day_id, shift_id, status_id, user_id) VALUES
             (#{r[:day_id]}, #{r[:shift_id]}, #{r[:status_id]},#{r[:user_id]})"]
            )
            DayCollection.connection.execute(sql)
          end
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
    if session[:view] == 'week'
      hash = { :year => date.year, :month => date.month, :day => date.day}
    end
    hash
  end

end