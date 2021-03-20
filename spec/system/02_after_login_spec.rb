require 'rails_helper'

describe '[STEP2] (会社側)ログイン後のテスト' do
    let(:company) { create(:company) }
    let!(:other_company) { create(:company) }
    let!(:project) { create(:project, company: company) }
    let!(:other_project) { create(:project, company: other_company) }

  before do
    visit new_company_session_path
    fill_in 'company[email]', with: company.email
    fill_in 'company[password]', with: company.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it 'JOIN HANDSを押すと、インフルエンサー一覧画面に遷移する' do
        JOINHANDS_link = find_all('a')[1].native.inner_text
        JOINHANDS_link = JOINHANDS_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link JOINHANDS_link
        is_expected.to eq companies_path
      end
    end
  end
  describe '案件一覧画面のテスト' do
     before do
      visit projects_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/projects'
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
        expect(page).to have_link project.title, href: project_path(project)
        expect(page).to have_link other_project.title, href: project_path(other_project)
      end
      it '自分の投稿と他人の投稿の報酬が表示される' do
        expect(page).to have_content project.price
        expect(page).to have_content other_project.price
      end
    end
  end

  describe '新規投稿画面のテスト' do
    before do
      visit new_project_path
    end

    context '案件投稿成功のテスト' do
      before do
        fill_in 'project[price]', with: Faker::Lorem.characters(number: 5)
        fill_in 'project[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'project[details]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿' }.to change(company.projects, :count).by(1)
      end
      it 'リダイレクト先が、案件一覧になっている' do
        click_button '投稿'
        expect(current_path).to eq projects_path
      end
    end
  end

  describe '自分の案件詳細画面のテスト' do
    before do
      visit project_path(project)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/projects/' + project.id.to_s
      end
      it '案件のtitleが表示される' do
        expect(page).to have_content project.title
      end
      it '案件のpriceが表示される' do
        expect(page).to have_content project.price
      end
      it '案件のdetailsが表示される' do
        expect(page).to have_content project.details
      end
      it '案件の削除リンクが表示される' do
        expect(page).to have_link '削除', href: project_path(project)
      end
    end

    context '削除リンクのテスト' do
      before do
        click_link '削除'
      end

      it '正しく削除される' do
        expect(Project.where(id: project.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/projects'
      end
    end
  end

  describe 'インフルエンサー一覧画面のテスト' do
    before do
      visit companies_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/companies'
      end
      # it '自分と他人の画像が表示される: fallbackの画像がサイドバーの1つ＋一覧(2人)の2つの計3つ存在する' do
      #   expect(all('img').size).to eq(3)
      # end
      # it '自分と他人の名前がそれぞれ表示される' do
      #   expect(page).to have_content influencer.name
      #   expect(page).to have_content other_influencer.name
      # end
      # it '自分と他人のshowリンクがそれぞれ表示される' do
      #   expect(page).to have_link 'Show', href: user_path(user)
      #   expect(page).to have_link 'Show', href: user_path(other_user)
      # end
    end
  end

  describe 'マイページ画面のテスト' do
    before do
      visit company_path(company)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/companies/' + company.id.to_s
      end
      it '自分の会社名が表示される' do
        expect(page).to have_content company.company_name
      end
      it '自分の会社概要が表示される' do
        expect(page).to have_content company.business_detail
      end
      it '自分の従業員数が表示される' do
        expect(page).to have_content company.employee_number
      end
      it '自分の代表者名が表示される' do
        expect(page).to have_content company.representative_name
      end
      it 'マイページに自分の投稿のtitleが表示され、リンクが正しい' do
        expect(page).to have_link project.title, href: project_path(project)
      end
      it 'マイページに自分の投稿のdetailsが表示される' do
        expect(page).to have_content project.details
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: company_path(other_company)
        expect(page).not_to have_content other_project.title
        expect(page).not_to have_content other_project.details
      end
      it 'プロフィール編集リンクが表示される' do
        expect(page).to have_link 'プロフィール編集', href: edit_company_path(company)
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_company_path(company)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/companies/' + company.id.to_s + '/edit'
      end
      it '編集フォームに会社名が表示される' do
        expect(page).to have_field 'company[company_name]', with: company.company_name
      end
      it '編集フォームに代表者名が表示される' do
        expect(page).to have_field 'company[representative_name]', with: company.representative_name
      end
      it '編集フォームにが事業内容が表示される' do
        expect(page).to have_field 'company[business_detail]', with: company.business_detail
      end
      it '編集フォームに従業員数が表示される' do
        expect(page).to have_field 'company[employee_number]', with: company.employee_number
      end
      it '変更を保存ボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @company_old_name = company.company_name
        @company_old_details = company.business_detail
        fill_in 'company[company_name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'company[business_detail]', with: Faker::Lorem.characters(number: 19)
        click_button '変更を保存'
      end

      it 'nameが正しく更新される' do
        expect(company.reload.company_name).not_to eq @company_old_name
      end
      it 'detailsが正しく更新される' do
        expect(company.reload.business_detail).not_to eq @company_old_details
      end
      it 'リダイレクト先が、自分のマイページ画面になっている' do
        expect(current_path).to eq '/companies/' + company.id.to_s
      end
    end
  end
end
describe '[STEP2] (インフルエンサー側)ログイン後のテスト' do
    let(:influencer) { create(:influencer) }
    # let!(:project) { create(:project, company: company) }

  before do
    visit new_influencer_session_path
    fill_in 'influencer[email]', with: influencer.email
    fill_in 'influencer[password]', with: influencer.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it 'JOIN HANDSを押すと、案件一覧画面に遷移する' do
        JOINHANDS_link = find_all('a')[1].native.inner_text
        JOINHANDS_link = JOINHANDS_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link JOINHANDS_link
        is_expected.to eq influencers_path
      end
    end
  end

  describe 'マイページ画面のテスト' do
    before do
      visit influencer_path(influencer)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/influencers/' + influencer.id.to_s
      end
      it '自分の活動名が表示される' do
        expect(page).to have_content influencer.nickname
      end
      it '自分のプロフィールが表示される' do
        expect(page).to have_content influencer.details
      end
      it '自分のフォロワー数が表示される' do
        expect(page).to have_content influencer.follower_count
      end
      it 'プロフィール編集リンクが表示される' do
        expect(page).to have_link 'プロフィール編集', href: edit_influencer_path(influencer)
      end
    end
  end
  
  describe 'マイページ編集画面のテスト' do
    before do
      visit edit_influencer_path(influencer)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/influencers/' + influencer.id.to_s + '/edit'
      end
      it '編集フォームにnameが表示される' do
        expect(page).to have_field 'influencer[name]', with: influencer.name
      end
      it '編集フォームにnicknameが表示される' do
        expect(page).to have_field 'influencer[nickname]', with: influencer.nickname
      end
      it '編集フォームにdetailsが表示される' do
        expect(page).to have_field 'influencer[details]', with: influencer.details
      end
      it '編集フォームにfollower_countが表示される' do
        expect(page).to have_field 'influencer[follower_count]', with: influencer.follower_count
      end
      it '編集フォームにaddressが表示される' do
        expect(page).to have_field 'influencer[address]', with: influencer.address
      end
      it '変更を保存ボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @influencer_old_name = influencer.name
        @influencer_old_details = influencer.details
        fill_in 'influencer[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'influencer[details]', with: Faker::Lorem.characters(number: 19)
        click_button '変更を保存'
      end

      it 'nameが正しく更新される' do
        expect(influencer.reload.name).not_to eq @influencer_old_name
      end
      it 'detailsが正しく更新される' do
        expect(influencer.reload.details).not_to eq @influencer_old_details
      end
      it 'リダイレクト先が、自分のマイページ画面になっている' do
        expect(current_path).to eq '/influencers/' + influencer.id.to_s
      end
    end
  end

  # describe '案件一覧画面のテスト' do
  #   before do
  #     visit influencers_path
  #   end

  #   context '表示内容の確認' do
  #     it 'URLが正しい' do
  #       expect(current_path).to eq '/influencers'
  #     end
  #     it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
  #       expect(page).to have_link project.title, href: project_path(project)
  #       expect(page).to have_link other_project.title, href: project_path(other_project)
  #     end
  #     it '自分の投稿と他人の投稿の報酬が表示される' do
  #       expect(page).to have_content project.price
  #       expect(page).to have_content other_project.price
  #     end
  #   end
  # end

end