require 'rails_helper'

describe '[STEP3] (Company側)仕上げのテスト', type: :system do
  let(:company) { create(:company) }
  let!(:other_company) { create(:company) }
  let!(:project) { create(:project, company: company) }
  let!(:other_project) { create(:project, company: other_company) }

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it 'ユーザログイン成功時' do
      visit new_company_session_path
      fill_in 'company[email]', with: company.email
      fill_in 'company[password]', with: company.password
      click_button 'ログイン'
      is_expected.to have_content 'ログインしました！'
    end

    it 'ユーザのプロフィール情報更新成功時' do
      visit new_company_session_path
      fill_in 'company[email]', with: company.email
      fill_in 'company[password]', with: company.password
      click_button 'ログイン'
      visit edit_company_path(company)
      click_button '変更を保存'
      is_expected.to have_content 'プロフィールを更新しました！'
    end

    it '案件新規投稿時' do
      visit new_company_session_path
      fill_in 'company[email]', with: company.email
      fill_in 'company[password]', with: company.password
      click_button 'ログイン'
      visit new_project_path
      fill_in 'project[title]', with: Faker::Lorem.characters(number: 5)
      fill_in 'project[price]', with: Faker::Lorem.characters(number: 5)
      fill_in 'project[details]', with: Faker::Lorem.characters(number: 20)
      click_button '投稿'
      is_expected.to have_text '投稿しました!'
    end
  end
end


describe '[STEP3] (influencer側)仕上げのテスト', type: :system do
  let(:influencer) { create(:influencer) }

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it 'ユーザログイン成功時' do
      visit new_influencer_session_path
      fill_in 'influencer[email]', with: influencer.email
      fill_in 'influencer[password]', with: influencer.password
      click_button 'ログイン'
      is_expected.to have_content 'ログインしました！'
    end

    it 'ユーザのプロフィール情報更新成功時' do
      visit new_influencer_session_path
      fill_in 'influencer[email]', with: influencer.email
      fill_in 'influencer[password]', with: influencer.password
      click_button 'ログイン'
      visit edit_influencer_path(influencer)
      click_button '変更を保存'
      is_expected.to have_content 'プロフィールを更新しました！'
    end
  end
end
