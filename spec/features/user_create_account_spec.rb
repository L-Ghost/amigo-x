require 'rails_helper'

feature 'User create account' do
  scenario 'successfully' do
    visit root_path
    click_on 'Criar nova Conta'

    fill_in 'Nome', with: 'Tobias'
    fill_in 'Email', with: 'tobias@avantasia.com'
    fill_in 'Senha', with: 'thescarecrow2008'
    fill_in 'Confirmar Senha', with: 'thescarecrow2008'
    click_on 'Enviar Dados'

    expect(page).to have_content('Logado como: tobias@avantasia.com')
    expect(page).not_to have_link('Criar nova Conta')
    expect(page).to have_link('Sair')
  end

  scenario 'and do not fill fields' do
    visit root_path
    click_on 'Criar nova Conta'

    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar Senha', with: ''
    click_on 'Enviar Dados'

    expect(page).to have_content('Não foi possível criar a conta')
  end
end