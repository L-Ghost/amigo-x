require 'rails_helper'

feature 'User views its groups' do
  scenario 'created by itself' do
    user = create(:user)
    xmas_group = create(:group, name: 'Natal 2018', user: user)
    estr_group = create(:group, name: 'Páscoa 2019', user: user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver grupos criados por mim'
    
    expect(page).to have_css('h1', text: "Grupos criados por #{user.name}")
    expect(page).to have_css('li', text: xmas_group.name)
    expect(page).to have_css('li', text: estr_group.name)
    expect(page).to have_content('Total de Grupos: 2')
  end

  scenario 'and see details of a single group' do
    user = create(:user)
    xmas_group = create(:group, name: 'Natal 2018', user: user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Ver grupos criados por mim'
    click_on xmas_group.name

    expect(current_path).to eq(group_path(xmas_group))
    expect(page).to have_css('h1', text: xmas_group.name)
    expect(page).to have_content("Criado por: #{user.email}")
  end

  scenario 'where user is a participant' do
    user = create(:user)
    group1 = create(:group)
    group2 = create(:group)
    group3 = create(:group)
    create(:group_participation, group: group1, user: user)
    create(:group_participation, group: group2, user: user)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Ver meus grupos'
    
    expect(page).to have_css('h1', text: "Meus Grupos")
    expect(page).to have_css('li', text: group1.name)
    expect(page).to have_css('li', text: group2.name)
    expect(page).not_to have_css('li', text: group3.name)
    expect(page).to have_content('Total de Grupos: 2')
  end
end