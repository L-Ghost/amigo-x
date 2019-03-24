class SessionParticipation < ApplicationRecord
  belongs_to :session
  belongs_to :user
  belongs_to :presented_user, class_name: 'User', optional: true
end
