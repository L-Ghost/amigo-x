FactoryBot.define do
  factory :session_participation do
    user
    session
    
    trait :after_raffle do
      presented_user
    end
  end
end