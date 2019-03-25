require 'rails_helper'

feature 'User makes raffle for session' do
  scenario 'successfully' do
    user = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    user5 = create(:user)
    group = create(:group, name: 'Amigos do Bar do Zé', user: user)
    create(:group_participation, user: user, group: group)
    create(:group_participation, user: user2, group: group)
    create(:group_participation, user: user3, group: group)
    create(:group_participation, user: user4, group: group)
    create(:group_participation, user: user5, group: group)
    sdf = create(:session, name: 'Sorteio de Fevereiro', group: group)
    create(:session_participation, user: user, session: sdf)
    create(:session_participation, user: user2, session: sdf)
    create(:session_participation, user: user3, session: sdf)
    create(:session_participation, user: user4, session: sdf)
    create(:session_participation, user: user5, session: sdf)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Ver meus grupos'
    click_on group.name
    click_on 'Ver sessões do Grupo'
    click_on sdf.name
    click_on 'Realizar Sorteio'
    
    expect(page).to have_content('Total de Participantes: 5')
    expect(page).not_to have_content('Ainda não foi realizado o sorteio desta Sessão')
    expect(page).not_to have_link('Realizar Sorteio')
    expect(page).to have_content('Sorteio realizado. Compre um belo presente para quem você tirou. =)')
    expect(page).to have_content('Você tirou o participante ')
  end
end