# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
MAIN_EMAIL = 'user@email.com'
users = [
    ['User 1', MAIN_EMAIL],
    ['User 2', 'user2@email.com'],
    ['User 3', 'user3@email.com'],
    ['User 4', 'user4@email.com'],
    ['User 5', 'user5@email.com']
]

users.each do |name, email|
  if !User.where(email: email).first
    User.create(name: name, email: email, password: '123456')
  end
end

main_user = User.where(email: MAIN_EMAIL).first

if !Group.where(name: 'Grupo Teste', user: main_user).first
  group = Group.create(name: 'Grupo Teste', user: main_user)
  users.each do |name, email|
    user = User.where(email: email).first
    GroupParticipation.create(group: group, user: user)
  end
end