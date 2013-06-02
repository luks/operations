class DayCollectionsController < ApplicationController
  # GET /day_collections
  # GET /day_collections.json
  def index

    @day = Day.all
    @day_collections = DayCollection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @day_collections }
    end
  end

  # GET /day_collections/1
  # GET /day_collections/1.json
  def show
    @day_collection = DayCollection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @day_collection }
    end
  end

  # GET /day_collections/new
  # GET /day_collections/new.json
  def new
    @day_collection = DayCollection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @day_collection }
    end
  end

  # GET /day_collections/1/edit
  def edit
    @day_collection = DayCollection.find(params[:id])
  end

  # POST /day_collections
  # POST /day_collections.json
  def create
    @day_collection = DayCollection.new(params[:day_collection])

    respond_to do |format|
      if @day_collection.save
        format.html { redirect_to @day_collection, notice: 'Day collection was successfully created.' }
        format.json { render json: @day_collection, status: :created, location: @day_collection }
      else
        format.html { render action: "new" }
        format.json { render json: @day_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /day_collections/1
  # PUT /day_collections/1.json
  def update
    @day_collection = DayCollection.find(params[:id])

    respond_to do |format|
      if @day_collection.update_attributes(params[:day_collection])
        format.html { redirect_to @day_collection, notice: 'Day collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @day_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day_collections/1
  # DELETE /day_collections/1.json
  def destroy
    @day_collection = DayCollection.find(params[:id])
    @day_collection.destroy

    respond_to do |format|
      format.html { redirect_to day_collections_url }
      format.json { head :no_content }
    end
  end


  def day

    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @day = Day.find_by_date(date)
    if @day.nil?
      @day = Day.create(:date => date);
      @day.save
    end
    @day_collection = DayCollection.new 
    respond_to do |format|
      format.html       
    end
  end

  def admin_day

    date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @day = Day.find_by_date(date)
    @users = User.all
    @users.count.times do |collection|
      @day_collection = @day.day_collections.build
    end
    

    respond_to do |format|
      format.html
    end
  end
end
