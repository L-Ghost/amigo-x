class Group < ApplicationRecord
  belongs_to :user

  validates :name, presence: {message: 'Você precisa informar o nome do Grupo'}
end
