require 'rails_helper'

describe '[STEP1] ログイン前のテスト' do
  describe 'toppage画面のテスト' do
    before do
      visit '/'
    end

    context '表示内容の確認' do
      it '表示コンテンツが正しい' do
        expect(page.body).to have_text'影響力のあるインフルエンサーと、商品やサービスをPRしたい企業のマッチングプラットフォーム'
      end
    end
  end

  describe 'influencer_info画面のテスト' do
    before do
      visit '/homes/influencer_info'
    end

    context '表示内容の確認' do
      it '表示コンテンツが正しい' do
        expect(page.body).to have_text'空いた時間にSNSで仕事ができる！'
      end
    end
  end

  describe 'company_info画面のテスト' do
    before do
      visit '/homes/company_info'
    end

    context '表示内容の確認' do
      it '表示コンテンツが正しい' do
        expect(page.body).to have_text'効率よくインフルエンサーに仕事の依頼をしませんか？'
      end
    end
  end

  describe 'influencer側新規登録のテスト' do
    before do
      visit new_influencer_registration_path
    end

    context '表示内容の確認' do
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'influencer[name]'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'influencer[name_kana]'
      end
      it 'nicknameフォームが表示される' do
        expect(page).to have_field 'influencer[nickname]'
      end
      it 'nicknameフォームが表示される' do
        expect(page).to have_field 'influencer[follower_count]'
      end
      it 'nicknameフォームが表示される' do
        expect(page).to have_field 'influencer[phone_number]'
      end
      it 'nicknameフォームが表示される' do
        expect(page).to have_field 'influencer[address]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'influencer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'influencer[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'influencer[password_confirmation]'
      end
      it '登録ボタンが表示される' do
        expect(page).to have_button '登録する'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'influencer[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'influencer[name_kana]', with: Faker::Lorem.characters(number: 10)
        fill_in 'influencer[nickname]', with: Faker::Lorem.characters(number: 10)
        fill_in 'influencer[follower_count]', with: Faker::Lorem.characters(number: 5)
        fill_in 'influencer[phone_number]', with: Faker::Lorem.characters(number: 11)
        fill_in 'influencer[address]', with: Faker::Lorem.characters(number: 10)
        fill_in 'influencer[email]', with: Faker::Internet.email
        fill_in 'influencer[password]', with: 'password'
        fill_in 'influencer[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '登録する' }.to change(Influencer.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、案件一覧画面になっている' do
        click_button '登録する'
        expect(current_path).to eq influencers_path
      end
    end
  end

  describe 'influencerログイン' do
    let(:influencer) { create(:influencer) }

    before do
      visit new_influencer_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/influencers/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'influencer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'influencer[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
      it 'nameフォームは表示されない' do
        expect(page).not_to have_field 'influencer[name]'
      end
    end
    context 'ログイン成功のテスト' do
      before do
        fill_in 'influencer[email]', with: influencer.email
        fill_in 'influencer[password]', with: influencer.password
        click_button 'ログイン'
      end
      it 'ログイン後のリダイレクト先が、案件一覧画面になっている' do
        expect(current_path).to eq influencers_path
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'influencer[email]', with: ''
        fill_in 'influencer[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/influencers/sign_in'
      end
    end

    describe 'influencerログアウトのテスト' do
      let(:influencer) { create(:influencer) }

      before do
        visit new_influencer_session_path
        fill_in 'influencer[email]', with: influencer.email
        fill_in 'influencer[password]', with: influencer.password
        click_button 'ログイン'
        logout_link = find_all('a')[3].native.inner_text
        logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link 'ログアウト'
      end

      context 'ログアウト機能のテスト' do
        it 'コンテンツが正しい' do
          expect(page).to have_text '影響力のあるインフルエンサーと、商品やサービスをPRしたい企業のマッチングプラットフォーム'
        end
        it 'company_infoのlinkが表示される' do
           expect(page).to have_link '', href: '/homes/company_info'
        end
        it 'influencer_infoのlinkが表示される' do
           expect(page).to have_link '', href: '/homes/influencer_info'
        end
        it 'ログアウト後のリダイレクト先が、トップになっている' do
          expect(current_path).to eq '/'
        end
      end
    end
  end

  describe 'influencerゲストログイン' do
    before do
      visit homes_influencer_info_path
      click_link 'ゲストログイン for influencer'
    end
    it 'ゲストログインが成功するか' do
       expect(current_path).to eq influencers_path
    end
  end

  describe 'company側新規登録のテスト' do
    before do
      visit new_company_registration_path
    end

    context '表示内容の確認' do
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it 'company_nameフォームが表示される' do
        expect(page).to have_field 'company[company_name]'
      end
      it 'representative_nameフォームが表示される' do
        expect(page).to have_field 'company[representative_name]'
      end
      it 'business_detailフォームが表示される' do
        expect(page).to have_field 'company[business_detail]'
      end
      it 'employee_numberフォームが表示される' do
        expect(page).to have_field 'company[employee_number]'
      end
      it '[phone_numberフォームが表示される' do
        expect(page).to have_field 'company[phone_number]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'company[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'company[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'company[password_confirmation]'
      end
      it '登録ボタンが表示される' do
        expect(page).to have_button '登録する'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'company[company_name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'company[representative_name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'company[business_detail]', with: Faker::Lorem.characters(number: 10)
        fill_in 'company[employee_number]', with: Faker::Lorem.characters(number: 10)
        fill_in 'company[phone_number]', with: Faker::Lorem.characters(number: 11)
        fill_in 'company[email]', with: Faker::Internet.email
        fill_in 'company[password]', with: 'password'
        fill_in 'company[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '登録する' }.to change(Company.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたmypageの詳細画面になっている' do
        click_button '登録する'
        expect(current_path).to eq company_path(Company.last.id)
      end
    end

    describe 'companyログイン' do
      let(:company) { create(:company) }

      before do
        visit new_company_session_path
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/companies/sign_in'
        end
        it '「ログイン」と表示される' do
          expect(page).to have_content 'ログイン'
        end
        it 'emailフォームが表示される' do
          expect(page).to have_field 'company[email]'
        end
        it 'passwordフォームが表示される' do
          expect(page).to have_field 'company[password]'
        end
        it 'ログインボタンが表示される' do
          expect(page).to have_button 'ログイン'
        end
        it 'nameフォームは表示されない' do
          expect(page).not_to have_field 'company[name]'
        end
      end

      context 'ログイン成功のテスト' do
        before do
          fill_in 'company[email]', with: company.email
          fill_in 'company[password]', with: company.password
          click_button 'ログイン'
        end
        it 'ログイン後のリダイレクト先が、ログインしたユーザーの詳細画面になっている' do
          expect(current_path).to eq '/companies/' + company.id.to_s
        end
      end

      context 'ログイン失敗のテスト' do
        before do
          fill_in 'company[email]', with: ''
          fill_in 'company[password]', with: ''
          click_button 'ログイン'
        end

        it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
          expect(current_path).to eq '/companies/sign_in'
        end
      end

      describe 'ログアウトのテスト' do
        let(:company) { create(:company) }

        before do
          visit new_company_session_path
          fill_in 'company[email]', with: company.email
          fill_in 'company[password]', with: company.password
          click_button 'ログイン'
          logout_link = find_all('a')[4].native.inner_text
          logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link 'ログアウト'
        end

        context 'ログアウト機能のテスト' do
          it '正しくログアウトできている: ログアウト後のリダイレクト先においてInfo画面へのリンクが存在する' do
            expect(page).to have_link '', href: '/homes/company_info'
          end
          it 'ログアウト後のリダイレクト先が、トップになっている' do
            expect(current_path).to eq '/'
          end
        end
      end
    end
  end

  describe 'companyゲストログイン' do
    before do
      visit homes_company_info_path
      click_link 'ゲストログイン for company'
    end
    it 'ゲストログイン成功' do
      expect(current_path).to eq '/companies/' + company.id.to_s
    end
  end

end
