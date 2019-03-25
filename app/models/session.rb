class Session < ApplicationRecord
  belongs_to :group
  has_many :session_participations
  has_many :users, through: :session_participations
  has_many :presented_users, through: :session_participations

  validates :name, presence: {message: 'Você precisa dar um nome para a Sessão'}
end
