require 'rails_helper'

describe '[STEP2] ログイン後のテスト' do
  #   let(:company) { create(:company) }
  #   let!(:other_company) { create(:company) }
  #   let!(:project) { create(:project, company: company) }
  #   let!(:other_project) { create(:project, company: other_company) }

  before do
    visit new_company_session_path
    fill_in 'company[email]', with: company.email
    fill_in 'company[password]', with: company.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it 'JOIN HANDSを押すと、自分のユーザ詳細画面に遷移する' do
        # join hands_link = find_all('a')[1].native.inner_text
        # join hands_link = joinhands_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link joinhands_link
        is_expected.to eq companies_path
      end
      # it 'Usersを押すと、ユーザ一覧画面に遷移する' do
      #   users_link = find_all('a')[2].native.inner_text
      #   users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link users_link
      #   is_expected.to eq '/users'
      # end
      # it 'Booksを押すと、投稿一覧画面に遷移する' do
      #   books_link = find_all('a')[3].native.inner_text
      #   books_link = books_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link books_link
      #   is_expected.to eq '/books'
      # end
    end
  end
end
