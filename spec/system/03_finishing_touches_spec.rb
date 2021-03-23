require 'rails_helper'
require 'selenium-webdriver'

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
  let(:influencer_project) { create(:influencer_project) }

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

    it 'company_review成功' do
      visit new_influencer_session_path
      fill_in 'influencer[email]', with: influencer.email
      fill_in 'influencer[password]', with: influencer.password
      click_button 'ログイン'
      visit influencer_projects_path
      # byebug
      find(:xpath,"/html/body/div/div[2]/div/a").click
      fill_in 'company_review[comment]', with: Faker::Lorem.characters(number: 5)
      fill_in 'company_review[rate]', with: '3'
      click_link '送信する'
      is_expected.to have_content '送信しました！'
    end
  end
end

describe '[STEP3] influencer_project', type: :system do
  let!(:influencer) { create(:influencer) }
  let!(:company) { create(:company) }
  let!(:influencer_project) { create(:influencer_project) }
  let!(:project) { create(:project, company: company, influencer_projects: [influencer_project]) }

  describe '[company側]influencer_project' do

    before do
      visit new_company_session_path
      fill_in 'company[email]', with: company.email
      fill_in 'company[password]', with: company.password
      click_button 'ログイン'
    end

    it 'company→influencer申請' do
      visit companies_path
      click_link "#{influencer.nickname}"
      click_link '申請'
      fill_in 'message', with: Faker::Lorem.characters(number: 5)
      click_button '送信'
      expect(page).to have_content '送信完了です'
    end

    it 'company→influencer完了', js: true do
      influencer_project.status = 2
      influencer_project.save
      click_link "#{project.reload.title}"
      click_link 'レビューする'
      page.driver.browser.switch_to.alert.accept
      fill_in 'comment', with: Faker::Lorem.characters(number: 5)
      find('#rating-form').find("img[alt='3']").click
      click_button '送信する'
      expect(page).to have_content '送信完了です'
    end
    
  end

  describe '[influencer側]influencer_project' do

    before do
      visit new_influencer_session_path
      fill_in 'influencer[email]', with: influencer.email
      fill_in 'influencer[password]', with: influencer.password
      click_button 'ログイン'
    end


    it 'influencer→company承諾' do
      visit influencer_projects_path
      save_and_open_page
      find(:xpath,"/html/body/div[2]/div[1]/div/a").click
      find("#influencer_project_id").find("option[value='2']").select_option
      fill_in 'influencer_project[influencer_message]', with: Faker::Lorem.characters(number: 5)
      click_link '送信する'
      is_expected.to have_content '送信しました！'
    end

    it 'influencer→company終了' do
      visit influencer_projects_path
      influencer_project.status = 3
      influencer_project.save
      save_and_open_page
      byebug
      find(:xpath,"/html/body/div/div[2]/div/a").click
      fill_in 'company_review[comment]', with: Faker::Lorem.characters(number: 5)
      fill_in 'company_review[rate]', with: '3'
      click_link '送信する'
      is_expected.to have_content '送信しました！'
    end
  end



end
