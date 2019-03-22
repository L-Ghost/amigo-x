require 'rails_helper'

feature 'User creates group' do
  scenario 'successfully' do
    user = create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Criar novo Grupo'
    fill_in 'Nome', with: 'Grupo da Empresa'
    click_on 'Confirmar'

    expect(current_path).to eq(group_path(Group.last))
    expect(page).to have_css('h1', text: Group.last.name)
    expect(page).to have_content("Criado por: #{Group.last.user.email}")
    expect(page).to have_content('Total de Participantes: 1')
  end

  scenario 'and must fill in name' do
    user = create(:user)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Criar novo Grupo'
    fill_in 'Nome', with: ''
    click_on 'Confirmar'

    expect(page).to have_content('Não foi possível criar o Grupo')
    expect(page).to have_content('Você precisa informar o nome do Grupo')
  end
end