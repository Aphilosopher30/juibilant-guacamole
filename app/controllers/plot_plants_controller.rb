class PlotPlantsController < ApplicationController
  def destroy

    plot_plant = PlotPlant.where("plot_plants.plot_id = ?", params[:plot_id])
    .where("plot_plants.plant_id = ?", params[:plant_id]).first

    PlotPlant.find(plot_plant.id).destroy

    redirect_to '/plots'

  end
end
