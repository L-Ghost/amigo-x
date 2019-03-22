class Group < ApplicationRecord
  belongs_to :user
  has_many :group_participations
  has_many :users, through: :group_participations

  validates :name, presence: {message: 'Você precisa informar o nome do Grupo'}
end
