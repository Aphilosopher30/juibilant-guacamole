require 'rails_helper'

RSpec.describe PlotPlant do
  describe 'relationships' do
    it { should belong_to(:plant) }
    it { should belong_to(:plot) }
    it { should have_many(:gardens).through(:plot) }

  end
end
