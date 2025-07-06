FactoryBot.define do
  factory :product do
    factory :green_tea do
      code { 'GR1' }
      name { 'Green Tea' }
      price { 3.11 }
    end

    factory :strawberries do
      code { 'SR1' }
      name { 'Strawberries' }
      price { 5.00 }
    end

    factory :coffee do
      code { 'CF1' }
      name { 'Coffee' }
      price { 11.23 }
    end
  end
end 