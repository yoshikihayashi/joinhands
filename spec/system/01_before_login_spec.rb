# require 'rails_helper'

# describe '[STEP1] ログイン前のテスト' do
#   # describe 'トップ画面のテスト' do
#   #   before do
#   #     visit root_path
#   #   end
#   #   context '表示内容の確認' do
#   #     it 'URLが正しい' do
#   #       expect(root_path).to eq '/'
#   #     end
#   #     it 'Log inリンクが表示される: 左上から5番目のリンクが「Log in」である' do
#   #       log_in_link = find_all('a')[5].native.inner_text
#   #       expect(log_in_link).to match(/log in/i)
#   #     end
#   #     it 'Log inリンクの内容が正しい' do
#   #       log_in_link = find_all('a')[5].native.inner_text
#   #       expect(page).to have_link log_in_link, href: new_user_session_path
#   #     end
#   #     it 'Sign Upリンクが表示される: 左上から6番目のリンクが「Sign Up」である' do
#   #       sign_up_link = find_all('a')[6].native.inner_text
#   #       expect(sign_up_link).to match(/sign up/i)
#   #     end
#   #     it 'Sign Upリンクの内容が正しい' do
#   #       sign_up_link = find_all('a')[6].native.inner_text
#   #       expect(page).to have_link sign_up_link, href: new_user_registration_path
#   #     end
#   #   end
#   # end
#   describe 'influencer_info画面のテスト' do
#     before do
#       visit '/homes/influencer_info'
#     end

#     context '表示内容の確認' do
#       it 'URLが正しい' do
#         expect(current_url).to eq '/homes/influencer_info'
#       end
#     end
#   end
# end