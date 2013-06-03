class DayCollectionsController < ApplicationController
  # GET /day_collections
  # GET /day_collections.json
  def index

    @day_collections = DayCollection.all
    @overview = session[:overview]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @day_collections }
    end
  end

  def set_overview
    session[:overview] = params[:overview] || 'week'
    respond_to do |format|
      format.html { redirect_to day_collections_url(params) }
    end
  end

  def destroy
    @day_collection = DayCollection.find(params[:id])
    day = @day_collection.day
    @day_collection.destroy

    respond_to do |format|
      format.html { redirect_to day_collections_url(redirect_to_date(day.date)) }
      format.json { head :no_content }
    end
  end

  def day

    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    day = Day.find_by_date(date)
    if day.nil?
      day = Day.create(:date => date);
      day.save
    end
    shift_id = params[:shift] == 'day' ? 1 : 2
    day_collection = day.day_collections.new(:user_id => 1,:status_id => 2, :shift_id => shift_id )
    day_collection.save
    respond_to do |format|
      format.html { redirect_to day_collections_url(redirect_to_date(day.date)) }
    end
    
  end
  
  def multiple

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
      format.html  do
        redirect_to day_collections_url(redirect_to_date(day.date))
      end
    end
  end

  def admin_day

    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @day = Day.find_by_date(date)
    if @day.nil?
      @day = Day.create(:date => date);
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

  private
  def redirect_to_date(date)
    hash = { :year => date.year, :month => date.month  }
    if session[:overview] == 'week'
      hash = { :year => date.year, :month => date.month, :day => date.day}
    end
    hash
  end

end
