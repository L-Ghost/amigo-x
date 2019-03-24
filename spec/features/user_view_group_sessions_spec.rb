require 'rails_helper'

feature 'User view group sessions' do
  scenario 'when it is owner of the group' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    group = create(:group, name: 'Amigos do Bar do Zé', user: user)
    create(:group_participation, user: user, group: group)
    create(:group_participation, user: user2, group: group)
    create(:group_participation, user: user3, group: group)
    create(:group_participation, user: user4, group: group)
    sdf = create(:session, name: 'Sorteio de Fevereiro', group: group)
    sda = create(:session, name: 'Sorteio de Abril', group: group)
    sdj = create(:session, name: 'Sorteio de Junho', group: group)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    
    expect(page).to have_css('h1', text: "#{group.name} - Sessões")
    expect(page).to have_link(sdf.name)
    expect(page).to have_link(sda.name)
    expect(page).to have_link(sdj.name)
    expect(page).to have_link('Criar nova Sessão')
    expect(page).to have_content('Total de Sessões: 3')
    expect(page).to have_link('Voltar para Grupo')
  end

  scenario 'when it is member of the group' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    group = create(:group, name: 'Amigos do Bar do Zé', user: user2)
    create(:group_participation, user: user, group: group)
    create(:group_participation, user: user2, group: group)
    create(:group_participation, user: user3, group: group)
    create(:group_participation, user: user4, group: group)
    sdf = create(:session, name: 'Sorteio de Fevereiro', group: group)
    sda = create(:session, name: 'Sorteio de Abril', group: group)
    sdj = create(:session, name: 'Sorteio de Junho', group: group)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    
    expect(page).to have_css('h1', text: "#{group.name} - Sessões")
    expect(page).to have_link(sdf.name)
    expect(page).to have_link(sda.name)
    expect(page).to have_link(sdj.name)
    expect(page).not_to have_link('Criar nova Sessão')
    expect(page).to have_content('Total de Sessões: 3')
    expect(page).to have_link('Voltar para Grupo')
  end
end