class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :groups
  has_many :group_participations
  has_many :groups_participating, through: :group_participations, source: :group
  
  validates :name, presence: {message: 'Você precisa informar um nome'}
end
