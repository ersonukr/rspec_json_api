FactoryGirl.define do
  factory :sitem do
    name { Faker::StarWars.character }
    done false
    stodo_id nil
  end
end