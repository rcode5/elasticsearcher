FactoryGirl.define do
  factory :author do
    name { Faker::Name.name }
    hometown { Faker::Address.city }
  end

end
