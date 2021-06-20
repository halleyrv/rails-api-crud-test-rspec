FactoryBot.define do
  factory :author, class: Author do
    first_name { "Cesar" }
    last_name { "Rivera" }
    age { 48 }
  end

  factory :author_two, class: Author do
    first_name { "Miguel" }
    last_name { "Vasconcellos" }
    age { 50 }
  end
end
