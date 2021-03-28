require 'rails_helper'
require 'selenium-webdriver'

describe '[STEP3] (Company側)仕上げのテスト', type: :system do
  let(:company) { create(:company) }
  let!(:other_company) { create(:company) }
  let!(:project) { create(:project, company: company) }
  let!(:other_project) { create(:project, company: other_company) }

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it 'ユーザ新規登録成功時' do
      visit new_company_registration_path
      fill_in 'company[company_name]', with: Faker::Lorem.characters(number: 10)
      fill_in 'company[representative_name]', with: Faker::Lorem.characters(number: 10)
      fill_in 'company[business_detail]', with: Faker::Lorem.characters(number: 10)
      fill_in 'company[employee_number]', with: Faker::Lorem.characters(number: 10)
      fill_in 'company[phone_number]', with: Faker::Lorem.characters(number: 11)
      fill_in 'company[email]', with: Faker::Internet.email
      fill_in 'company[password]', with: 'password'
      fill_in 'company[password_confirmation]', with: 'password'
      click_button '登録する'
      is_expected.to have_content 'ログインしました！'
    end

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

    it '案件新規投稿成功' do
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

    it '案件新規投稿失敗' do
      visit new_company_session_path
      fill_in 'company[email]', with: company.email
      fill_in 'company[password]', with: company.password
      click_button 'ログイン'
      visit new_project_path
      fill_in 'project[title]', with: ''
      fill_in 'project[price]', with: ''
      fill_in 'project[details]', with: ''
      click_button '投稿'
      is_expected.to have_text '投稿に失敗しました。。'
    end

    it '案件削除' do
      visit new_company_session_path
      fill_in 'company[email]', with: company.email
      fill_in 'company[password]', with: company.password
      click_button 'ログイン'
      click_link "#{project.reload.title}"
      click_link '削除'
      expect(page).to have_content '投稿を削除しました!'
    end
    
    it '案件の編集成功時' do
      visit new_company_session_path
      fill_in 'company[email]', with: company.email
      fill_in 'company[password]', with: company.password
      click_button 'ログイン'
      visit edit_project_path(project)
      click_button '投稿'
      is_expected.to have_content '編集完了です'
    end
  end

  describe '他人の案件詳細画面のテスト' do
    before do
      visit project_path(other_project)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/projects/' + other_project.id.to_s
      end
      it '案件のtitleが表示される' do
        expect(page).to have_content other_project.title
      end
      it '案件のpriceが表示される' do
        expect(page).to have_content other_project.price
      end
      it '案件のdetailsが表示される' do
        expect(page).to have_content other_project.details
      end
      it '案件の削除リンクが表示されない' do
        expect(page).not_to have_link '削除'
      end
      it '案件の編集リンクが表示されない' do
        expect(page).not_to have_link '編集'
      end
    end
  end
end

describe '[STEP3] (influencer側)仕上げのテスト', type: :system do
  let(:influencer) { create(:influencer) }
  let(:influencer_project) { create(:influencer_project) }

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it '新規登録成功時' do
      visit new_influencer_registration_path
      fill_in 'influencer[name]', with: Faker::Lorem.characters(number: 10)
      fill_in 'influencer[name_kana]', with: Faker::Lorem.characters(number: 10)
      fill_in 'influencer[nickname]', with: Faker::Lorem.characters(number: 10)
      fill_in 'influencer[follower_count]', with: Faker::Lorem.characters(number: 5)
      fill_in 'influencer[phone_number]', with: Faker::Lorem.characters(number: 11)
      fill_in 'influencer[address]', with: Faker::Lorem.characters(number: 10)
      fill_in 'influencer[email]', with: Faker::Internet.email
      fill_in 'influencer[password]', with: 'password'
      fill_in 'influencer[password_confirmation]', with: 'password'
      click_button '登録する'
      is_expected.to have_content 'ログインしました！'
    end

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
      fill_in 'influencer[email]', with: influencer_project.influencer.email
      fill_in 'influencer[password]', with: influencer_project.influencer.password
      click_button 'ログイン'
    end

    it 'influencer→company承諾' do
      visit influencer_projects_path
      find(:xpath, "/html/body/div/div[1]/div/a").click
      find("#influencer_project_status").find("option[value='2']").select_option
      fill_in 'influencer_project[influencer_message]', with: Faker::Lorem.characters(number: 5)
      click_button '送信する'
      expect(page).to have_content '送信完了です！'
    end

    it 'influencer→company終了', js: true do
      influencer_project.status = 3
      influencer_project.save
      visit influencer_projects_path
      find(:xpath, "/html/body/div/div[2]/div/a").click
      fill_in 'company_review[comment]', with: Faker::Lorem.characters(number: 5)
      find('#rating-form').find("img[alt='3']").click
      click_button '送信する'
      expect(page).to have_content '送信しました'
    end
  end
end
