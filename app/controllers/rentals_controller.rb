class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @camera = Camera.find(params[:camera_id])
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    @camera = Camera.find(params[:camera_id])
    @rental.camera = @camera
    @rental.user = current_user

    if @rental.save
      redirect_to rental_path(@rental)
    else
      render :new
    end
  end

  def destroy
    @rental = Rental.find(params[:id])
    @rental.destroy

    redirect_to rentals_path
  end

  def accepted!
    @rental = Rental.find(params[:rental_id])
    @rental.status = 1
    @rental.save

    render :show
  end

  def declined!
    @rental = Rental.find(params[:rental_id])
    @rental.status = 2
    @rental.save

    render :show
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :status)
  end
end
