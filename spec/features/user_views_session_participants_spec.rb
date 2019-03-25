require 'rails_helper'

feature 'User views session participants' do
  scenario 'when it is owner of group, and raffle is yet to occur' do
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
    create(:session_participation, user: user, session: sdf)
    create(:session_participation, user: user2, session: sdf)
    create(:session_participation, user: user3, session: sdf)
    create(:session_participation, user: user4, session: sdf)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    click_on sdf.name
    
    expect(page).to have_css('h1', text: "#{group.name} - #{sdf.name}")
    expect(page).to have_css('h3', text: 'Participantes da Sessão')
    expect(page).to have_content(user.name)
    expect(page).to have_content(user2.name)
    expect(page).to have_content(user3.name)
    expect(page).to have_content(user4.name)
    expect(page).to have_content('Total de Participantes: 4')
    expect(page).to have_content('Ainda não foi realizado o sorteio desta Sessão')
    expect(page).to have_link('Realizar Sorteio')
    expect(page).not_to have_content('Você tirou o participante ')
    expect(page).to have_link('Voltar para Sessões')
  end

  scenario 'when it is owner of the group, and raffle has already occurred' do
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
    create(:session_participation, :after_raffle, user: user, session: sdf, presented_user: user2)
    create(:session_participation, :after_raffle, user: user2, session: sdf, presented_user: user3)
    create(:session_participation, :after_raffle, user: user3, session: sdf, presented_user: user4)
    create(:session_participation, :after_raffle, user: user4, session: sdf, presented_user: user)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    click_on sdf.name
    
    expect(page).to have_css('h1', text: "#{group.name} - #{sdf.name}")
    expect(page).to have_css('h3', text: 'Participantes da Sessão')
    expect(page).to have_content(user.name)
    expect(page).to have_content(user2.name)
    expect(page).to have_content(user3.name)
    expect(page).to have_content(user4.name)
    expect(page).to have_content('Total de Participantes: 4')
    expect(page).not_to have_content('Ainda não foi realizado o sorteio desta Sessão')
    expect(page).not_to have_link('Realizar Sorteio')
    expect(page).to have_content("Você tirou o participante #{user2.name}")
    expect(page).to have_link('Voltar para Sessões')
  end

  scenario 'when raffle has already occurred, and user is not group owner' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    group = create(:group, name: 'Amigos do Bar do Zé', user: user3)
    create(:group_participation, user: user, group: group)
    create(:group_participation, user: user2, group: group)
    create(:group_participation, user: user3, group: group)
    create(:group_participation, user: user4, group: group)
    sda = create(:session, name: 'Sorteio de Abril', group: group)
    create(:session_participation, :after_raffle, user: user, session: sda, presented_user: user3)
    create(:session_participation, :after_raffle, user: user2, session: sda, presented_user: user4)
    create(:session_participation, :after_raffle, user: user3, session: sda, presented_user: user)
    create(:session_participation, :after_raffle, user: user4, session: sda, presented_user: user2)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    click_on sda.name

    expect(page).to have_css('h1', text: "#{group.name} - #{sda.name}")
    expect(page).not_to have_content('Ainda não foi realizado o sorteio desta Sessão')
    expect(page).not_to have_link('Realizar Sorteio')
    expect(page).to have_content("Você tirou o participante #{user3.name}")
  end

  scenario 'when raffle is yet to occur, and user is not group owner' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    group = create(:group, name: 'Amigos do Bar do Zé', user: user4)
    create(:group_participation, user: user, group: group)
    create(:group_participation, user: user2, group: group)
    create(:group_participation, user: user3, group: group)
    create(:group_participation, user: user4, group: group)
    sda = create(:session, name: 'Sorteio de Abril', group: group)
    create(:session_participation, user: user, session: sda)
    create(:session_participation, user: user2, session: sda)
    create(:session_participation, user: user3, session: sda)
    create(:session_participation, user: user4, session: sda)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    click_on sda.name

    expect(page).to have_css('h1', text: "#{group.name} - #{sda.name}")
    expect(page).to have_content('Ainda não foi realizado o sorteio desta Sessão')
    expect(page).not_to have_link('Realizar Sorteio')
    expect(page).not_to have_content('Você tirou o participante ')
  end
end