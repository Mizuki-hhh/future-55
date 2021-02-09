require 'rails_helper'

# def basic_pass(path)
#   username = ENV["FUTURE_AUTH_USER"]
#   password = ENV["FUTURE_AUTH_PASSWORD"]
#   visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
# end

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # Basic認証を経てトップページに遷移する
      # basic_pass root_path
      # トップページにサインアップページに遷移するボタンがあることを確認する
      visit root_path
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      find("#user_role").find("option[value='contributor']").select_option
      fill_in 'name', with: @user.name
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      find("#user_birthday_1i").find("option[value='1993']").select_option
      find("#user_birthday_2i").find("option[value='5']").select_option
      find("#user_birthday_3i").find("option[value='7']").select_option
      fill_in 'occupation', with: @user.occupation
      # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # ログアウトボタンが表示されていること確認する
      expect(page).to have_content('ログアウト')
      # 新規登録ページへ遷移するボタンと、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページに戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      find("#user_role").find("option[value='contributor']").select_option
      fill_in 'name', with: ""
      fill_in 'email', with: ""
      fill_in 'password', with: ""
      fill_in 'password-confirmation', with: ""
      find("#user_birthday_1i").find("option[value='']").select_option
      find("#user_birthday_2i").find("option[value='']").select_option
      find("#user_birthday_3i").find("option[value='']").select_option
      fill_in 'occupation', with: ""
      # 新規登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe "ユーザーログイン機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保持されているユーザーの情報と合致すればログインができる' do
      # Basic認証を経てトップページに移動する
      # basic_pass root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      visit root_path
      expect(page).to have_content('ログイン')
      # ログインページに移動する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # 自分の名前が表示されていることを確認する
      expect(page).to have_content(@user.name)
      # ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')
      # 新規登録ページへ遷移するボタンが表示されていなことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_link('ログイン')
      # トップページに「ログインしました」というポプアップがでる確認する
      expect(page).to have_content('ログインしました')
    end
  end

  context 'ログインができないとき' do
    it '保持されているユーザーの情報と合致しないとログインができない' do
      # トップページへ遷移する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end
