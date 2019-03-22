FactoryBot.define do
  factory :group do
    sequence(:name) {|i| "Group #{i}"}
    user
  end
end
