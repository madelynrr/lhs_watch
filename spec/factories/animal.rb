FactoryBot.define do
  factory :animal do
    name { "Maya" }
    lhs_id  { "12345" }
    species { 0 }
    gender { 1 }
    age { 9 }
    status { 1 }
    favorite { true }
  end
end
