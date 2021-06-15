# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'
require "open-uri"

  # Remember you shouldnt destroy in the seed file in normal circumstances.

Review.destroy_all
RouteTag.destroy_all
CycleRoute.destroy_all
Tag.destroy_all
User.destroy_all


admin = User.create!(email: 'admin@rideriot.club', password: '123456', name: "Kiz", points: 39, routes_completed: 3, distance_cycled: 47) unless admin = User.find_by_email('admin@rideriot.club')
kiz = URI.open('https://res.cloudinary.com/duae8ljpg/image/upload/v1623687480/rideriot/kieryn_o9alpo.jpg')
admin.photo.attach(io: kiz, filename: "kiz.jpg", content_type: 'image/jpg')
  # Remember you shouldnt destroy in the seed file in normal circumstances.
tags = {
  scenic: Tag.new(name: 'Scenic'),
  quiet: Tag.new(name: 'Quiet'),
  historic: Tag.new(name: 'Historic'),
  challenging: Tag.new(name: 'Challenging')
}

tags.each_value { |tag| tag.save }

cycle_routes = {
  vicPark: CycleRoute.new(
    name: "Victoria Park",
    start_point: "Goodrich House, Sewardstone Road, London",
    end_point: "East Village, Stratford, London",
    way_points: "23 Sherrin Road E10 5SQ, 2 Forest Road N17 9NH, 116 Columbia Road E2 7RG, 91 Brick Lane E1 6QL",
    map_image: "rideriot/vicMap_ndt8xg.png",
    total_distance: 2.5,
    description: "Winner of the Green Flag award for the best UK park for the previous two years. The internal roadway is wide enough for people to cycle, walk and jog in the same space.",
    user: admin
  ),
  regents: CycleRoute.new(
    name: "Regents Canal",
    start_point: "139 Graham St, N1 8LB, London",
    end_point: "84 Victoria Park Rd E9 7JL",
    way_points: "283a Kingsland Rd E2 8AS London",
    map_image: "rideriot/regentsMap_zrldo1.png",
    total_distance: 1.2,
    description: "One of London’s best-kept secrets. Take in scenic views and miss out the congestion, crowds and noise.",
    user: admin
  ),
  cs1: CycleRoute.new(
    name: "CS1",
    start_point: "Finsbury Circus, EC2M 7DT, London",
    end_point:  "Finsbury Circus, EC2M 7DT, London",
    way_points: "40 Great Russell Street WC1B 3DA, 117 Benwell Road N7 7BW, 16 Whitmore Road N1 5QA",
    map_image: "rideriot/cs1Map_lqarfs.png",
    total_distance: 1.5,
    description: "London's first Cycle Superhighway is a great way to explore London on roads you probably won't have used on a bike before.",
    user: admin
  ),
  tower: CycleRoute.new(
    name: "Tower of London",
    start_point: "Tower of London, London EC3N 4AB",
    end_point: "Montfichet Rd E20 1EJ",
    way_points: "56 Brushfield Street E1 6AA, St Mary Axe E15 2SN, 64 Chisenhale Rd Bow E3 5QZ",
    map_image: "rideriot/towerMap_qsrsdt.png",
    total_distance: 1.8,
    description: "The Tower of London has played a prominent role in English history, and is one of the country's most popular tourist attractions. ",
    user: admin
  )
}

cycle_routes.each_value { |cycle_route| cycle_route.save }

RouteTag.create(cycle_route: cycle_routes[:vicPark], tag: tags[:scenic])
RouteTag.create(cycle_route: cycle_routes[:vicPark], tag: tags[:quiet])
RouteTag.create(cycle_route: cycle_routes[:regents], tag: tags[:scenic])
RouteTag.create(cycle_route: cycle_routes[:cs1], tag: tags[:quiet])
RouteTag.create(cycle_route: cycle_routes[:tower], tag: tags[:historic])

@rand_review = ['Pretty good cycle', Faker::Hacker.say_something_smart, 'unimpressed, I hit a bus :(', Faker::ChuckNorris.fact, 'Great!', 'Very pretty']
@route_ids = CycleRoute.ids.map(&:to_i)

5.times do
  @user = User.new(name: Faker::FunnyName.name, points: rand(0..90), password: "123456", email: Faker::Internet.email, routes_completed: rand(0..10), distance_cycled: rand(0.40))
  @user.save!

  4.times do
    review = Review.new(comment: @rand_review.sample, rating: rand(0..5), cycle_route_id: @route_ids.sample, user_id: @user.id)
    review.save!
  end
end


