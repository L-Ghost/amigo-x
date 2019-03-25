require 'rails_helper'

feature 'User creates new session for group' do
  scenario 'successfully' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    group = create(:group, name: 'Turma do D&D', user: user)
    create(:group_participation, user: user, group: group)
    create(:group_participation, user: user2, group: group)
    create(:group_participation, user: user3, group: group)
    create(:group_participation, user: user4, group: group)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    click_on 'Criar nova Sessão'
    fill_in 'Nome', with: 'Sorteio Comic Con'
    click_on 'Confirmar'
    
    expect(page).to have_css('h1', text: "#{group.name} - Sessões")
    expect(page).to have_link('Sorteio Comic Con')
    expect(page).to have_content('Total de Sessões: 1')
    expect(current_path).to eq(group_sessions_path(group))
  end

  scenario 'but leaves session name empty' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    group = create(:group, name: 'Turma do D&D', user: user)
    create(:group_participation, user: user, group: group)
    create(:group_participation, user: user2, group: group)
    create(:group_participation, user: user3, group: group)
    create(:group_participation, user: user4, group: group)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    click_on 'Criar nova Sessão'
    fill_in 'Nome', with: ''
    click_on 'Confirmar'
    
    expect(page).to have_content('Não foi possível criar a Sessão')
    expect(page).to have_content('Você precisa dar um nome para a Sessão')
    expect(Session.count).to eq(0)
  end

  scenario 'and views session participants' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    group = create(:group, name: 'Turma do D&D', user: user)
    create(:group_participation, user: user, group: group)
    create(:group_participation, user: user2, group: group)
    create(:group_participation, user: user3, group: group)
    create(:group_participation, user: user4, group: group)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    click_on 'Criar nova Sessão'
    fill_in 'Nome', with: 'Sorteio Anime Friends'
    click_on 'Confirmar'
    click_on Session.last.name
    
    expect(page).to have_content(user.name)
    expect(page).to have_content(user2.name)
    expect(page).to have_content(user3.name)
    expect(page).to have_content(user4.name)
    expect(page).to have_content('Total de Participantes: 4')
  end

  scenario 'only if group has more than three participants' do
    user = create(:user)
    user2 = create(:user)
    group = create(:group, name: 'Turma do D&D', user: user)
    create(:group_participation, user: user, group: group)
    create(:group_participation, user: user2, group: group)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    click_on 'Criar nova Sessão'
    fill_in 'Nome', with: 'Sorteio Campus Party'
    click_on 'Confirmar'

    expect(page).to have_content('Não foi possível criar a Sessão')
    expect(page).to have_content('É necessário haver no mínimo três pessoas participando de um grupo para criar uma Sessão')
    expect(Session.count).to eq(0)
  end
end