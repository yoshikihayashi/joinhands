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

    # it 'ユーザのプロフィール情報更新成功時' do
    #   visit new_company_session_path
    #   fill_in 'company[email]', with: company.email
    #   fill_in 'company[password]', with: company.password
    #   click_button 'ログイン'
    #   visit edit_company_path(company)
    #   click_button '変更を保存'
    #   is_expected.to have_content 'プロフィールを更新しました！'
    # end
  end
end
