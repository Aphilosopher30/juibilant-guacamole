require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  describe 'instance methods:' do

    describe 'get_plants: ' do
      it "returns list of plants that belong to the garden" do

        q_gardens = Garden.create!(name: "Q gardens", organic: false)
        eden = Garden.create!(name: "eden", organic: true)

        plot_q1 = q_gardens.plots.create!(number: 1,  size: "small", direction: "north")
        plot_e1 = eden.plots.create!(number: 3,  size: "small", direction: "west")
        plot_e2 = eden.plots.create!(number: 4,  size: "large", direction: "east")

        apple = Plant.create!(name: "apple", harvest: 19, description: "cruncy")
        orange = Plant.create!(name: "orange", harvest: 12, description: "it's orange")
        pair = Plant.create!(name: "pair", harvest: 33, description: "just one or two")
        life = Plant.create!(name: "life", harvest: 99, description: "eternal life")

        apple_q1 = PlotPlant.create!(plant: apple, plot: plot_q1  )

        orange_e1 = PlotPlant.create!(plant: orange , plot: plot_e1)

        pair_e1 = PlotPlant.create!(plant: pair , plot: plot_e1)
        pair_q1 = PlotPlant.create!(plant: pair , plot: plot_q1)

        life_e2 = PlotPlant.create!(plant: life , plot: plot_e2)

        expected = [orange, pair, life]

        expect(eden.get_plants).to eq(expected)
      end

      it "each plant is unique" do

        eden = Garden.create!(name: "eden", organic: true)

        plot_e1 = eden.plots.create!(number: 3,  size: "small", direction: "west")
        plot_e2 = eden.plots.create!(number: 4,  size: "large", direction: "east")

        apple = Plant.create!(name: "apple", harvest: 19, description: "cruncy")
        orange = Plant.create!(name: "orange", harvest: 12, description: "it's orange")
        pair = Plant.create!(name: "pair", harvest: 33, description: "just one or two")
        life = Plant.create!(name: "life", harvest: 99, description: "eternal life")


        orange_e1 = PlotPlant.create!(plant: orange , plot: plot_e1)
        orange_e2 = PlotPlant.create!(plant: orange , plot: plot_e2)

        pair_e1 = PlotPlant.create!(plant: pair , plot: plot_e1)
        pair_e2 = PlotPlant.create!(plant: pair , plot: plot_e2)

        life_e2 = PlotPlant.create!(plant: life , plot: plot_e2)

        expected = [orange, pair, life]

        expect(eden.get_plants).to eq(expected)
      end

      it "each plant takes less than 100 days to harvest" do

        Garden.create!(name: "Q gardens", organic: false)
        eden = Garden.create!(name: "eden", organic: true)

        plot_q1 = q_gardens.plots.create!(number: 1,  size: "small", direction: "north")
        plot_e1 = eden.plots.create!(number: 3,  size: "small", direction: "west")
        plot_e2 = eden.plots.create!(number: 4,  size: "large", direction: "east")

        apple = Plant.create!(name: "apple", harvest: 19, description: "cruncy")
        orange = Plant.create!(name: "orange", harvest: 12, description: "it's orange")
        pair = Plant.create!(name: "pair", harvest: 33, description: "just one or two")
        life = Plant.create!(name: "life", harvest: 1000, description: "eternal life")

        apple_q1 = PlotPlant.create!(plant: apple, plot: plot_q1  )

        orange_e1 = PlotPlant.create!(plant: orange , plot: plot_e1)

        pair_e1 = PlotPlant.create!(plant: pair , plot: plot_e1)
        pair_e2 = PlotPlant.create!(plant: pair , plot: plot_e2)
        pair_q1 = PlotPlant.create!(plant: pair , plot: plot_q1)

        life_e2 = PlotPlant.create!(plant: life , plot: plot_e2)

        expected = [orange, pair]

        expect(eden.get_plants).to eq(expected)
      end
    end


  end

end
