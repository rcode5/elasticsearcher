FactoryGirl.define do
  factory :post do
    title { Faker::Commerce.product_name }
    body { Faker::Lorem::paragraphs(3).join("\n") }
  end

end
