class GardensController < ApplicationController
  before_action :set_garden, only: [:show, :edit, :update, :destroy, :bulk_add, :bulk_harvest]
  before_action :load_plants, only: [:show]

  # GET /gardens
  def index
    @gardens = Garden.all
  end

  # GET /gardens/1
  def show
  end

  # GET /gardens/new
  def new
    @garden = Garden.new
  end

  # GET /gardens/1/edit
  def edit
  end

  # POST /gardens
  def create
    @garden = Garden.new(garden_params)

    if @garden.save
      redirect_to @garden, notice: 'Garden was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /gardens/1
  def update
    if @garden.update(garden_params)
      redirect_to @garden, notice: 'Garden was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /gardens/1
  def destroy
    @garden.destroy
    redirect_to gardens_url, notice: 'Garden was successfully destroyed.'
  end

  def bulk_harvest
    params[:coords].each do |k, v|
      plant = GardenPlant.unharvested.where(garden_id: @garden.id, x_pos: v.first, y_pos: v.last).first
      plant.update_attribute(:harvested_at, Time.now)
    end

    respond_to do |format|
      format.json {
        render json: {success: true}, status: 201
      }
    end
  end

  def bulk_add
    # TODO: limit to 20 at a time
    @plant = Plant.find(params[:plant_id])

    Garden.transaction do
      params[:coords].each do |k, v|
        @garden.garden_plants << GardenPlant.new(plant_id: params[:plant_id], x_pos: v.first, y_pos: v.last)
      end
      @garden.save
    end

    respond_to do |format|
      format.json {
        if @garden.errors.any?
          render json: {success: false, message: "There was a problem planting #{@plant.name}"}, status: 500
        else
          render json: {success: true}, status: 201
        end
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garden
      @garden = Garden.includes(:plants).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def garden_params
      params.require(:garden).permit(:name, :style, :user_id, :width, :length, :depth, :hours_of_sun)
    end
end
