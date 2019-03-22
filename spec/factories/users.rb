FactoryBot.define do
  factory :user do
    sequence(:name) {|i| "User #{i}"}
    sequence(:email) {|i| "email#{i}@amigox.com"}
    password { 8.times.map { Random.rand(10) }.join }
  end
end