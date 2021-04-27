class GardensController < ApplicationController

  def show

    @garden = Garden.find(params[:garden_id])

    # @plants = @garden.plants.where("plants.harvest < 100 ").group("plants.id")
    @plants = @garden.get_plants




  end

end
