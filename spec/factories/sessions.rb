FactoryBot.define do
  factory :session do
    sequence(:name) {|i| "Session #{i}"}
    group
  end
end