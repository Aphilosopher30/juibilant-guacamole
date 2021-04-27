require 'rails_helper'

RSpec.describe 'plots index page' do

  describe 'lists all plots' do
    it "shows plot number" do
      q_gardens = Garden.create!(name: "Q gardens", organic: false)
      eden = Garden.create!(name: "eden", organic: true)

      plot_q1 = q_gardens.plots.create!(number: 1,  size: "small", direction: "north")
      plot_q2 = q_gardens.plots.create!( number: 2,  size: "medium", direction: "south")
      plot_e1 = eden.plots.create!(number: 3,  size: "small", direction: "west")
      plot_e2 = eden.plots.create!(number: 4,  size: "large", direction: "east")

      visit "/plots"

      within "#plot-#{plot_q1.id}" do
        expect(page).to have_content(plot_q1.number)
      end
      within "#plot-#{plot_q2.id}" do
        expect(page).to have_content(plot_q2.number)
      end

      within "#plot-#{plot_e2.id}" do
        expect(page).to have_content(plot_e2.number)
      end
      within "#plot-#{plot_e2.id}" do
        expect(page).to have_content(plot_e2.number)
      end
    end
  end

  describe 'listing plants' do
    it "lists plants info for each plot" do
      q_gardens = Garden.create!(name: "Q gardens", organic: false)
      eden = Garden.create!(name: "eden", organic: true)

      plot_q1 = q_gardens.plots.create!(number: 1,  size: "small", direction: "north")
      plot_q2 = q_gardens.plots.create!( number: 2,  size: "medium", direction: "south")
      plot_e1 = eden.plots.create!(number: 3,  size: "small", direction: "west")
      plot_e2 = eden.plots.create!(number: 4,  size: "large", direction: "east")

      apple = Plant.create!(name: "apple", harvest: 19, description: "cruncy")
      orange = Plant.create!(name: "orange", harvest: 12, description: "it's orange")
      pair = Plant.create!(name: "pair", harvest: 33, description: "just one or two")
      life = Plant.create!(name: "life", harvest: 1000, description: "eternal life")

      apple_q1 = PlotPlant.create!(plant: apple, plot: plot_q1  )
      apple_e2 = PlotPlant.create!(plant: apple, plot: plot_q2  )
      apple_e1 = PlotPlant.create!(plant: apple, plot: plot_e1  )

      orange_q2 = PlotPlant.create!(plant: orange , plot: plot_q2)
      orange_e1 = PlotPlant.create!(plant: orange , plot: plot_e1)
      orange_e2 = PlotPlant.create!(plant: orange , plot: plot_e2)

      pair_e1 = PlotPlant.create!(plant: pair , plot: plot_e1)
      pair_e2 = PlotPlant.create!(plant: pair , plot: plot_e2)
      pair_q1 = PlotPlant.create!(plant: pair , plot: plot_q1)

      life_e2 = PlotPlant.create!(plant: life , plot: plot_e2)
      life_q1 = PlotPlant.create!(plant: life , plot: plot_q1)
      life_q2 = PlotPlant.create!(plant: life , plot: plot_q2)

      visit "/plots"

      within "#plot-#{plot_q1.id}" do
        expect(page).to have_content(apple.name)
        expect(page).to have_no_content(orange.name)
        expect(page).to have_content(pair.name)
        expect(page).to have_content(life.name)
      end
      within "#plot-#{plot_q2.id}" do
        expect(page).to have_content(apple.name)
        expect(page).to have_content(orange.name)
        expect(page).to have_no_content(pair.name)
        expect(page).to have_content(life.name)
      end

      within "#plot-#{plot_e1.id}" do
        expect(page).to have_content(apple.name)
        expect(page).to have_content(orange.name)
        expect(page).to have_content(pair.name)
        expect(page).to have_no_content(life.name)
      end
      within "#plot-#{plot_e2.id}" do
        expect(page).to have_no_content(apple.name)
        expect(page).to have_content(orange.name)
        expect(page).to have_content(pair.name)
        expect(page).to have_content(life.name)
      end
    end
  end

  describe 'remove plants from garden' do
    it "lists link to remove next to each plant" do
      q_gardens = Garden.create!(name: "Q gardens", organic: false)
      eden = Garden.create!(name: "eden", organic: true)

      plot_q1 = q_gardens.plots.create!(number: 1,  size: "small", direction: "north")
      plot_e1 = eden.plots.create!(number: 3,  size: "small", direction: "west")

      apple = Plant.create!(name: "apple", harvest: 19, description: "cruncy")
      orange = Plant.create!(name: "orange", harvest: 12, description: "it's orange")

      apple_q1 = PlotPlant.create!(plant: apple, plot: plot_q1  )
      apple_e1 = PlotPlant.create!(plant: apple, plot: plot_e1  )

      orange_q1 = PlotPlant.create!(plant: orange , plot: plot_q1)
      orange_e1 = PlotPlant.create!(plant: orange , plot: plot_e1)

      visit "/plots"

      within "#plot-#{plot_q1.id}" do
        within "#plant-#{apple.id}" do
          expect(page).to have_link("remove")
        end
        within "#plant-#{orange.id}" do
          expect(page).to have_link("remove")
        end
      end

      within "#plot-#{plot_e1.id}" do
        within "#plant-#{apple.id}" do
          expect(page).to have_link("remove")
        end
        within "#plant-#{orange.id}" do
          expect(page).to have_link("remove")
        end
      end
    end

    it "the link removes a plant" do

      q_gardens = Garden.create!(name: "Q gardens", organic: false)
      eden = Garden.create!(name: "eden", organic: true)

      plot_q1 = q_gardens.plots.create!(number: 1,  size: "small", direction: "north")
      plot_e1 = eden.plots.create!(number: 3,  size: "small", direction: "west")

      apple = Plant.create!(name: "apple", harvest: 19, description: "cruncy")
      orange = Plant.create!(name: "orange", harvest: 12, description: "it's orange")

      apple_q1 = PlotPlant.create!(plant: apple, plot: plot_q1  )
      apple_e1 = PlotPlant.create!(plant: apple, plot: plot_e1  )

      orange_q1 = PlotPlant.create!(plant: orange , plot: plot_q1)
      orange_e1 = PlotPlant.create!(plant: orange , plot: plot_e1)

      visit "/plots"

      within "#plot-#{plot_q1.id}" do
        within "#plant-#{apple.id}" do
          expect(page).to have_content(apple.name)
        end
        within "#plant-#{orange.id}" do
          expect(page).to have_content(orange.name)
        end
      end

      within "#plot-#{plot_e1.id}" do
        within "#plant-#{apple.id}" do
          expect(page).to have_content(apple.name)
        end
        within "#plant-#{orange.id}" do
          expect(page).to have_content(orange.name)
        end
      end

      within "#plot-#{plot_q1.id}" do
        within "#plant-#{apple.id}" do
          click_link "remove"
        end
      end

      expect(current_path).to eq("/plots")


      within "#plot-#{plot_q1.id}" do
        expect(page).to have_no_content(apple.name)

        within "#plant-#{orange.id}" do
          expect(page).to have_content(orange.name)
        end
      end

      within "#plot-#{plot_e1.id}" do
        within "#plant-#{apple.id}" do
          expect(page).to have_content(apple.name)
        end
        within "#plant-#{orange.id}" do
          expect(page).to have_content(orange.name)
        end
      end
    end
  end
end
