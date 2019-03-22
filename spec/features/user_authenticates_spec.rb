require 'rails_helper'

feature 'User authenticates' do
  scenario 'and gets to home page' do
    user = User.create!(name: 'Arjen', email: 'arjen@ayreon.com', password: '01011001')
    visit root_path
    click_on 'Entrar'

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_on 'Login'
    
    expect(current_path).to eq(root_path)
    expect(page).to have_css('h3', text: "Bem vindo #{user.name}")
    expect(page).to have_css('p', text: "Logado como #{user.email}")
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Criar nova Conta')
  end

  scenario 'and logs out' do
    user = User.create!(name: 'Arjen', email: 'arjen@ayreon.com', password: '01011001')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).not_to have_css('h3', text: "Bem vindo #{user.name}")
    expect(page).not_to have_css('p', text: "Logado como #{user.email}")
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
    expect(page).to have_link('Criar nova Conta')
  end
end