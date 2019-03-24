class Session < ApplicationRecord
  belongs_to :group
  has_many :session_participations
  has_many :users, through: :session_participations
end
