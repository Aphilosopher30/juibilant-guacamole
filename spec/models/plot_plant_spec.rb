require 'rails_helper'

RSpec.describe PlotPlant do
  describe 'relationships' do
    it { should belong_to(:plant) }
    it { should have_many(:gardens).through(:plots) }
    it { should belong_to(:plots) }
  end
end
