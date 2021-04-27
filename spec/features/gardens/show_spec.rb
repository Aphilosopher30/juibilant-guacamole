require 'rails_helper'

RSpec.describe 'garden show page' do

  it 'it shows atributes of the garden' do
    eden = Garden.create!(name: "eden", organic: true)

    visit "/gardens/#{eden.id}"

    expect(page).to have_content(eden.name)
    expect(page).to have_content("oganic: #{eden.organic}")

  end


  describe "list of all plants:" do
    it "lists plants from it's plots" do
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
      pair_e2 = PlotPlant.create!(plant: pair , plot: plot_e2)
      pair_q1 = PlotPlant.create!(plant: pair , plot: plot_q1)

      life_e2 = PlotPlant.create!(plant: life , plot: plot_e2)

      visit "/gardens/#{eden.id}"

      expect(page).to have_content(orange.name)
      expect(page).to have_content(pair.name)
      expect(page).to have_content(life.name)
      expect(page).to have_no_content(apple.name)
    end

    # it "the plants are displayed only once"do
    #   q_gardens = Garden.create!(name: "Q gardens", organic: false)
    #   eden = Garden.create!(name: "eden", organic: true)
    #
    #   plot_q1 = q_gardens.plots.create!(number: 1,  size: "small", direction: "north")
    #   plot_e1 = eden.plots.create!(number: 3,  size: "small", direction: "west")
    #   plot_e2 = eden.plots.create!(number: 4,  size: "large", direction: "east")
    #
    #   apple = Plant.create!(name: "apple", harvest: 19, description: "cruncy")
    #   orange = Plant.create!(name: "orange", harvest: 12, description: "it's orange")
    #   pair = Plant.create!(name: "pair", harvest: 33, description: "just one or two")
    #   life = Plant.create!(name: "life", harvest: 99, description: "eternal life")
    #
    #   apple_q1 = PlotPlant.create!(plant: apple, plot: plot_q1  )
    #
    #   orange_e1 = PlotPlant.create!(plant: orange , plot: plot_e1)
    #
    #   pair_e1 = PlotPlant.create!(plant: pair , plot: plot_e1)
    #   pair_e2 = PlotPlant.create!(plant: pair , plot: plot_e2)
    #   pair_q1 = PlotPlant.create!(plant: pair , plot: plot_q1)
    #
    #   life_e2 = PlotPlant.create!(plant: life , plot: plot_e2)
    #
    #   visit "/gardens/#{eden.id}"
    #
    #
    #
    #
    # end

    it "the plants take less than 100 days to harvest" do
      q_gardens = Garden.create!(name: "Q gardens", organic: false)
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

      expect(page).to have_content(orange.name)
      expect(page).to have_content(pair.name)
      expect(page).to have_no_content(life.name)
      expect(page).to have_no_content(apple.name)
    end
  end




end
