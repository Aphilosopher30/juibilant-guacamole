require 'rails_helper'

RSpec.describe PlotPlant do
  describe 'relationships' do
    it { should have_many(:plot_plants) }
    it { should have_many(:gardens).through(:plots) }
    it { should have_many(:plots).through(:plot_plants) }
  end
end
