class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants

  def get_plants
    self.plants.where("plants.harvest < 100 ").group("plants.id")
  end

end
