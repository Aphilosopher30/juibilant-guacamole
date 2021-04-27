class PlotPlant < ApplicationRecord
  belongs_to :plant
  belongs_to :plot
  has_many :gardens, through: :plot

end
