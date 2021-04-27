# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


PlotPlant.destroy_all
Plot.destroy_all
Plant.destroy_all
Garden.destroy_all


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
apple_e1 = PlotPlant.create!(plant: apple, plot: plot_e2  )

orange_q2 = PlotPlant.create!(plant: orange , plot: plot_q2  )
orange_e1 = PlotPlant.create!(plant: orange , plot: plot_e1  )
orange_e2 = PlotPlant.create!(plant: orange , plot: plot_e2  )

pair_e1 = PlotPlant.create!(plant: pair , plot: plot_e1  )
pair_e2 = PlotPlant.create!(plant: pair , plot: plot_e2  )
pair_q1 = PlotPlant.create!(plant: pair , plot: plot_q1  )

life_e2 = PlotPlant.create!(plant: life , plot: plot_e2  )
life_q1 = PlotPlant.create!(plant: life , plot: plot_q1  )
life_q2 = PlotPlant.create!(plant: life , plot: plot_q2)
