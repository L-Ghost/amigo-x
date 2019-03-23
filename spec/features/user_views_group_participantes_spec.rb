require 'rails_helper'

feature 'User views Group Participants' do
  scenario 'navigating from home' do
    group_creator = create(:user)
    group = create(:group, user: group_creator, name: 'Grupo da Faculdade')
    create(:group_participation, user: group_creator, group: group)
    participants = []
    5.times {participants.push(create(:user))}
    participants.each do |participant|
      create(:group_participation, user: participant, group: group)
    end
    login_as(group_creator, scope: :user)

    visit root_path
    click_on 'Ver grupos criados por mim'
    click_on group.name
    
    expect(page).to have_css('h3', text: 'Participantes do Grupo')
    expect(page).to have_content(group_creator.name)
    expect(page).to have_content(participants[0].name)
    expect(page).to have_content(participants[1].name)
    expect(page).to have_content(participants[2].name)
    expect(page).to have_content(participants[3].name)
    expect(page).to have_content(participants[4].name)
    expect(page).to have_content('Total de Participantes: 6')
    expect(page).to have_link('Adicionar Participantes')
  end

  scenario 'and sees add participant page' do
    group_creator = create(:user)
    group = create(:group, user: group_creator, name: 'Grupo da Faculdade')
    login_as(group_creator, scope: :user)
    
    visit root_path
    click_on 'Ver grupos criados por mim'
    click_on group.name
    click_on 'Adicionar Participantes'
    
    expect(page).to have_content("Adicionar participantes para #{group.name}")
    expect(page).to have_link('Voltar para Grupo')
  end

  scenario 'without adding any participant' do
    group_creator = create(:user)
    group = create(:group, user: group_creator, name: 'Grupo da Faculdade')
    create(:group_participation, user: group_creator, group: group)
    login_as(group_creator, scope: :user)

    visit root_path
    click_on 'Ver grupos criados por mim'
    click_on group.name

    expect(page).to have_content('Total de Participantes: 1')
    expect(page).to have_link('Adicionar Participantes')
  end
end