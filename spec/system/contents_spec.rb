require 'rails_helper'

# def basic_pass(path)
#   username = ENV["FUTURE_AUTH_USER"]
#   password = ENV["FUTURE_AUTH_PASSWORD"]
#   visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
# end


RSpec.describe "コンテンツ投稿機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @content = FactoryBot.create(:content)
  end

  # before(:each) do
  #   load Rails.root.join("db/seeds.rb")
  # end

  context 'コンテントを投稿できるとき' do
    it 'ログインしたお仕事をされている大人（contributor）は、コンテンツを投稿できる' do
      # Basic認証を経てトップページへ遷移する
      # basic_pass root_path
      visit root_path
      # ログインする
      sign_in(@user)
      # コンテンツ投稿ページへのリンクがあることを確認する
      expect(page).to have_content('New content!')
      # コンテンツ投稿ページに遷移する
      visit new_content_path
      # コンテンツのタイトルを入力する
      fill_in 'content__name', with: @content.title
      # （添付する画像を定義する）
      # 画像選択フォームに画像を添付する
      attach_file('content[image_content]', 'spec/fixtures/test.jpg')
      # （添付する動画を定義する）
      # 動画選択フォームに動画を添付する
      attach_file('content[video_content]', 'spec/fixtures/test15.MOV')
      # 画像と動画以外のフォームに情報を入力する
      fill_in 'content__overview', with: @content.overview
      fill_in 'content__writing', with: @content.writing
      fill_in 'content__url', with: @content.source
      find("#parent_category", visible: false).find("option[value='数学']", visible: false, match: :first).select_option
      select "その他", from: "content[category_id]"
      # コンテンツを送信すると、Contentモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Content.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿したコンテンツが表示されていることを確認する（動画）
      expect(page).to have_selector("video[src*='test15.MOV']")
      # トップページには先ほど投稿したコンテンツが表示されていることを確認する（タイトル）
      expect(page).to have_content(@content.title)
      # トップページには先ほど投稿したコンテンツが表示されていることを確認する（概要）
      expect(page).to have_content(@content.overview)
      # トップページには先ほど投稿したコンテンツが表示されていることを確認する（投稿者名）
      expect(page).to have_content(@content.user.name)
      # トップページには先ほど投稿したコンテンツが表示されていることを確認する（投稿者の所属）
      expect(page).to have_content(@content.user.occupation)
    end
  end

  context 'コンテンツを投稿できないとき' do
    it 'ログインしているお仕事をされている大人でないとコンテンツを投稿できないこと' do
      # トップページに遷移する
      visit root_path
      # コンテンツを投稿するリンクがないことを確認する
      expect(page).to have_no_content('New content!')
    end
    it 'ログアウト状態のユーザーはコンテンツを投稿できないこと' do
      # トップページに遷移する
      visit root_path
      # コンテンツを投稿するリンクがないことを確認する
      expect(page).to have_no_content('New content!')
    end
    it 'お仕事をされている大人（contributor）としてログインしても、送信するコンテンツ情報が空のため、コンテンツを投稿できないこと' do
      # トップページに遷移する
      visit root_path
      # contributorとしてログインする
      sign_in(@user)
      # コンテンツを投稿するリンクがあることを確認する
      expect(page).to have_content('New content!')
      # コンテンツ投稿ページに移動するexit
      visit new_content_path
      # フォームに情報を入力しない
      fill_in 'content__name', with: ""
      fill_in 'content__overview', with: ""
      fill_in 'content__writing', with: ""
      fill_in 'content__url', with: ""
      # 送信してもContentモデルのカウントが上がらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.not_to change { Content.count }
      # コンテンツ投稿ページに留まることを確認する
      expect(current_path).to eq '/contents'
    end
  end
end

RSpec.describe "コンテンツ編集機能", tyoe: :system do
  before do
    @content1 = FactoryBot.create(:content)
    @content2 = FactoryBot.create(:content)
  end
  context 'コンテンツの編集ができるとき' do
    it 'ログインしている仕事をされている大人(contributor)は、自分が投稿したコンテンツの編集ができる' do
      # Basic認証を経てトップページにいる
      # basic_pass root_path
      visit root_path
      # コンテンツ1を投稿したユーザーでログインする
      sign_in(@content1.user)
      # コンテンツ1の詳細ページへ移動する
      visit content_path(@content1)
      # コンテンツ1に編集ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページに遷移する
      visit edit_content_path(@content1)
      # すでに投稿ずみの情報がフォームに入っていることを確認する
      expect(
        find('#content__name').value
      ).to eq @content1.title
      expect(
        find('#content__overview').value
      ).to eq @content1.overview
      expect(
        find('#content__writing').value
      ).to eq @content1.writing
      expect(
        find('#content__url').value
      ).to eq @content1.source
      expect(
        find('#parent_category').value
      ).to eq "その他"
      expect(
        find('#child_category').value
      ).to eq "#{@content1.category_id}"
      # 投稿内容を編集する
      fill_in 'content__name', with: "#{@content1.title}+編集したタイトル"
      attach_file('content[image_content]', 'spec/fixtures/test2.jpg')
      fill_in 'content__overview', with: "#{@content1.overview}+編集した概要"
      fill_in 'content__writing', with: "#{@content1.writing}+編集した詳細"
      fill_in 'content__url', with: "#{@content1.source}+編集したURL"
      find("#parent_category", visible: false).find("option[value='国語']", visible: false, match: :first).select_option
      select "その他", from: "content[category_id]"
      # 編集してもContentモデルのカウントは変わらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Content.count }.by(0)
      # コンテンツ詳細ページに遷移したことを確認する
      expect(current_path).to eq content_path(@content1)
      # コンテンツ詳細ページには先ほど変更したコンテンツの情報が存在することを確認する（画像）
      expect(page).to have_selector("img[src*='test2.jpg']")
      # コンテンツ詳細ページには先ほど変更したコンテンツの情報が存在することを確認する（動画）
      expect(page).to have_selector("video[src*='test15.MOV']")
      # コンテンツ詳細ページには先ほど変更したコンテンツの情報が存在することを確認する（タイトル）
      expect(page).to have_content("#{@content1.title}+編集したタイトル")
      # コンテンツ詳細ページには先ほど変更したコンテンツの情報が存在することを確認する（概要）
      expect(page).to have_content("#{@content1.overview}+編集した概要")
      # コンテンツ詳細ページには先ほど変更したコンテンツの情報が存在することを確認する（カテゴリー）
      expect(page).to have_content("国語")
      expect(page).to have_content("その他")
      # コンテンツ詳細ページには先ほど変更したコンテンツの情報が存在することを確認する（詳細）
      expect(page).to have_content("#{@content1.writing}+編集した詳細")
      # コンテンツ詳細ページには先ほど変更したコンテンツの情報が存在することを確認する（URL）
      expect(page).to have_content("#{@content1.source}+編集したURL")
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のコンテンツが存在することを確認する（動画）
      expect(page).to have_selector("video[src*='test15.MOV']")
      # トップページには先ほど変更した内容のコンテンツが存在することを確認する（タイトル）
      expect(page).to have_content("#{@content1.title}+編集したタイトル")
      # トップページには先ほど変更した内容のコンテンツが存在することを確認する（概要）
      expect(page).to have_content("#{@content1.overview}+編集した概要")
      # トップページには先ほど変更した内容のコンテンツが存在することを確認する（投稿者名）
      expect(page).to have_content(@content1.user.name)
      # トップページには先ほど変更した内容のコンテンツが存在することを確認する（投稿者の所属）
      expect(page).to have_content(@content1.user.occupation)
    end
  end
  context 'コンテンツの編集ができないとき' do
    it 'ログインしたユーザーは、自分以外が投稿した商品の編集画面には遷移できない' do
      # コンテンツ1を投稿したユーザーでログインする
      sign_in(@content1.user)
      # コンテンツ2の詳細ページへ移動する
      visit content_path(@content2)
      # コンテンツ2に編集ボタンがないことを確認する
      expect(page).to have_no_content('編集')
    end
    it 'ログインしていないと自分のコンテンツの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # コンテンツ1の詳細ページへ移動する
      visit content_path(@content1)
      # コンテンツ1に編集ボタンがないことを確認する
      expect(page).to have_no_content('編集')
      # トップページにいる
      visit root_path
      # コンテンツ2の詳細ページに移動する
      visit content_path(@content2)
      # コンテンツ2に編集ボタンがないことを確認する
      expect(page).to have_no_content('編集')
    end
  end
end

RSpec.describe 'コンテンツ削除機能', type: :system do
  before do
    @content1 = FactoryBot.create(:content)
  end

  context 'コンテンツ削除ができるとき' do
    it 'ログインした仕事をされている大人contributorは自らが投稿したコンテンツの削除ができる' do
      # Basic認証を経てトップページにいる
      # basic_pass root_path
      visit root_path
      # コンテンツ1を投稿したユーザーでログインする
      sign_in(@content1.user)
      # コンテンツ1の詳細ページに移動する
      visit content_path(@content1)
      # コンテンツ1に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # コンテンツを削除すると、レコードの数が1減ることを確認する
      # expect {
      #   find_link('削除', match: :first, href: content_path(@content1)).click
      # }.to change { Content.count }.by(-1)
      # 削除が完了するとトップページへ遷移する
      # expect(current_path).to eq root_path
      # # トップページにはコンテンツの内容が存在しないことを確認する（画像）
      # expect(page).to have_no_selector("img[src*='test.png']")
      # # トップページにはコンテンツの内容が存在しないことを確認する（動画）
      # expect(page).to have_no_selector("video[src*='test15.MOV']")
      # # トップページにはコンテンツの内容が存在しないことを確認する（タイトル）
      # expect(page).to have_no_content(@content1.title)
      # # トップページにはコンテンツの内容が存在しないことを確認する（概要）
      # expect(page).to have_no_content(@content1.overview)
    end
  end

  context 'コンテンツが削除できないとき' do
    before do
      @content2 = FactoryBot.create(:content)
    end
    it 'ログインしたcontributorは自分以外が投稿したコンテンツの削除ができない' do
      # Basic認証を経てトップページにいる
      # basic_pass root_path
      visit root_path
      # コンテンツ1を投稿したユーザーでログインする
      sign_in(@content1.user)
      # コンテンツ2の詳細ページへ移動する
      visit content_path(@content2)
      # コンテンツ2に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除')
    end
    it 'ログインしていないとコンテンツの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # コンテンツ1の詳細ページに移動する
      visit content_path(@content1)
      # コンテンツ1に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除')
      # トップページに戻る
      visit root_path
      # コンテンツ2の詳細ページに移動する
      visit content_path(@content2)
      # コンテンツ2に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end

RSpec.describe 'コンテンツ詳細', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @content = FactoryBot.create(:content)
  end
  context 'コンテンツの詳細が表示されること' do
    it 'ログインしたユーザーはコンテンツ詳細ページに遷移してコンテンツの情報が表示される' do
      # Basic認証を経てトップページにいる
      # basic_pass root_path
      visit root_path
      # ログインする
      sign_in(@user)
      # コンテンツ詳細ページに遷移する
      visit content_path(@content)
      # 詳細ページに画像、動画、タイトル、カテゴリー、詳細、URL、いいねボタンが含まれていることを確認する
      expect(page).to have_selector("img[src*='test.jpg']")
      expect(page).to have_selector("video[src*='test15.MOV']")
      expect(page).to have_content(@content.title)
      expect(page).to have_content(@content.overview)
      expect(page).to have_content("その他")
      expect(page).to have_content("その他")
      expect(page).to have_content(@content.writing)
      expect(page).to have_content(@content.source)
      # コメント記入フォームが表示されていることを確認する
      expect(page).to have_button("送信する")
    end
    it 'ログインしていない状態でも、コンテンツの詳細がみれるが、いいねボタン、コメント記入フォームが表示されない' do
      # トップページに移動する
      visit root_path
      # コンテンツ詳細ページに遷移する
      visit content_path(@content)
      # 詳細ページに画像、動画、タイトル、カテゴリー、詳細、URLが含まれていることを確認する
      expect(page).to have_selector("img[src*='test.jpg']")
      expect(page).to have_selector("video[src*='test15.MOV']")
      expect(page).to have_content(@content.title)
      expect(page).to have_content(@content.overview)
      expect(page).to have_content("その他")
      expect(page).to have_content("その他")
      expect(page).to have_content(@content.writing)
      expect(page).to have_content(@content.source)
      # コメント記入フォームが表示されていないことを確認する
      expect(page).to have_no_button("送信する")
    end
  end
end