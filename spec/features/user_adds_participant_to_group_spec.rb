require 'rails_helper'

feature 'User adds participant to group' do
  scenario 'only if user is owner of the group' do
    user = create(:user)
    group = create(:group)
    create(:group_participation, user: user, group: group)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name

    expect(page).not_to have_link('Adicionar Participantes')
  end

  scenario 'by informing one participant email' do
    user = create(:user)
    user2 = create(:user)
    group = create(:group, name: 'Jogadores de Tabuleiro', user: user)
    create(:group_participation, user: user, group: group)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Adicionar Participantes'
    fill_in 'Email', with: user2.email
    click_on 'Confirmar'

    expect(page).to have_content("Usuário #{user2.name} (#{user2.email}) foi adicionado ao grupo #{group.name}")
    expect(page).to have_content("Adicionar participantes para #{group.name}")
    expect(page).to have_link('Voltar para Grupo')
  end

  scenario 'by informing two participants emails and checking back group' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    group = create(:group, name: 'Jogadores de Tabuleiro', user: user)
    create(:group_participation, user: user, group: group)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Adicionar Participantes'
    fill_in 'Email', with: user2.email
    click_on 'Confirmar'
    fill_in 'Email', with: user3.email
    click_on 'Confirmar'
    click_on 'Voltar para Grupo'

    expect(page).to have_content(user.name)
    expect(page).to have_content(user2.name)
    expect(page).to have_content(user3.name)
    expect(page).to have_content('Total de Participantes: 3')
  end

  scenario 'but informs another user wrong email' do
    user = create(:user)
    group = create(:group, name: 'Jogadores de Tabuleiro', user: user)
    create(:group_participation, user: user, group: group)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Adicionar Participantes'
    fill_in 'Email', with: 'teste@teste.com'
    click_on 'Confirmar'

    expect(page).to have_content("Não foi encontrado um usuário com este email. Verifique o endereço informado.")
    expect(page).to have_content("Adicionar participantes para #{group.name}")
    expect(page).to have_link('Voltar para Grupo')
  end
end