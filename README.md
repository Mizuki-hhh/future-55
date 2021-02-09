# 概要

#### アプリケーション名
「FUTURE」

#### アプリケーション概要
画像または動画と、文章が投稿でき、そのコンテンツを閲覧することができるサイトです。
お仕事をされている方は、コンテンツを投稿でき、学生の方は、コンテンツを閲覧できます。
ログインしている全てのユーザーはコンテンツにコメントを残すこと、いいねボタンを押すことができます。


# 本番環境

#### URL
https://future-55.herokuapp.com/

#### Basic認証
ID : future

PASSWORD : 2525

#### テスト用アカウント
＜仕事をされている方（コンテンツが投稿できる方）＞
* 投稿者 1
  - メールアドレス：contributor1@gmail.com
  - パスワード：contributor1
* 投稿者 2
  - メールアドレス：contributor2@gmail.com
  - パスワード：contributor2

＜学生＞
* 学生 1
  - メールアドレス：student1@gmail.com
  - パスワード：student1
* 学生2
  - メールアドレス：student2@gmail.com
  - パスワード：student2


# 動作確認方法

 WebブラウザGoogle Chromeの最新版を利用してアクセスしてください。
  - ただしデプロイ等で接続できないタイミングもございます。その際は少し時間を置いてから接続してください。

 接続先およびログイン情報については上記の通りです。なお、同時に複数の方がログインしている場合に、ログインできない可能性がございます。

* コンテンツ投稿方法
  - 「仕事をされている方」のアカウントでログイン→トップページから「New content!」押下→コンテンツ情報を入力→コンテンツ投稿
  - 現在、容量の重い動画を投稿できないため、画像の投稿をお願いいたします。
* コンテンツ閲覧方法
  - 一覧に表示されたコンテンツの画像または動画、タイトル、概要をクリックしていただくと、コンテンツの詳細ページがご覧いただけます。
* 確認後、ログアウト処理をお願いいたします。


# 目指した課題解決

中学生くらいの年齢の学生さんの、将来への関心ごとを広げられるように、好きなことや興味を見つけてもらう、また、楽しんでもらうために、このアプリケーションを実装いたしました。
また、実際にお仕事をされている方々にコンテンツを投稿してもらうことで、将来への視野が広がることを理想としています。


# 洗い出した要件
* ユーザー管理機能
* コンテンツ投稿・編集・削除機能
* コンテンツ一覧表示機能
* ユーザー詳細（マイページ）表示機能
* コメント投稿機能
* カテゴリー検索機能
* いいねボタン機能
* エラーメッセージの日本語化


# 実装した機能についてのGIFと説明
* ユーザー管理機能
  - Cancancanを用いて、仕事ユーザーにはコンテンツが投稿できる権限を付与しました。
  - はじめに、ログインしているのが仕事ユーザーであれば画面右の少し上に、「New content!」というリンクがありますが、次に学生がログインした時にはリンクがありません。

  ![authuser2](https://user-images.githubusercontent.com/75303327/106878107-ea257280-671c-11eb-9bc3-e76c657b16af.gif)

* コンテンツ投稿・編集・削除機能
  - 仕事ユーザーは、タイトル、画像または動画、概要、詳細、URL、カテゴリーを選択または入力すると、コンテンツを投稿できます。また、コンテンツ詳細画面から、緑のボタンより、編集・削除ができます。

  ![neweditdelete2](https://user-images.githubusercontent.com/75303327/106878966-ea723d80-671d-11eb-9ec5-243c486d7c0a.gif)

* コンテンツ一覧表示機能
  - トップページにコンテンツ一覧が表示されます。画像または動画、タイトル、概要、投稿者名、所属が表示されます。
  - また、左端にはメニューバーがあり、カーソルを合わせると、メニューが表示されます。

  ![indexmenu2](https://user-images.githubusercontent.com/75303327/106887628-c49e6600-6728-11eb-9e0e-8e4d1c3b08a6.gif)

* ユーザー詳細（マイページ）表示機能
  - ログインしたユーザーは画面右上のリンクから自分のマイページに遷移することができます。仕事ユーザーのマイページへ飛ぶと、投稿したコンテンツを見ることができます。今回は次にコメント欄から学生のマイページに飛びましたが、学生のマイページは、その学生本人しか見ることができない仕様としました。
  - ログインした全てのユーザーは自分のマイページでのみ、いいねボタンを押したコンテンツの一覧が表示されます。

  ![futuremypages2](https://user-images.githubusercontent.com/75303327/106880484-c283d980-671f-11eb-94ba-8a67289d58fd.gif)

* コメント投稿機能
  - ログインした全てのユーザーは、コンテンツ詳細ページの下部から、コメントを残すことができます。コメントは本文、名前、日付が非同期で表示されます。ログアウト状態のユーザーはコメントを見ることはできますが、記入欄は表示されません。

  ![testcomment2](https://user-images.githubusercontent.com/75303327/106880857-37571380-6720-11eb-84ba-3fdf1f0789cc.gif)

* カテゴリー検索機能
  - 全てのユーザーは、トップページのカテゴリーのリンクにカーソルを合わせると、子カテゴリーまでが表示され、子カテゴリークリックすると、子カテゴリーに分類されたコンテンツ一覧を確認することができます。

  ![categorysearch2](https://user-images.githubusercontent.com/75303327/106884114-3c1dc680-6724-11eb-9e68-1ac881da8e3e.gif)

* 検索フォームからの検索機能
  - 全てのユーザーは、トップページの検索フォームから、検索したい言葉を検索することができます。タイトル、概要、詳細の中から検索ワードを抽出し、検索結果の一覧が表示されます。（今回は「について」というワードを検索しました。） 

  ![enginesearch2](https://user-images.githubusercontent.com/75303327/106887882-24950c80-6729-11eb-92c1-feab6c5eb53d.gif)

* いいねボタン機能
  - ログイン状態の全てのユーザーは、コンテンツ一覧から、いいねボタンを押すことができます。また、コンテンツ詳細ページからも、いいねボタンを押すことができます。ログアウト状態のユーザーには、いいねボタン（ハートマーク）は表示されません。

  ![likebutton2](https://user-images.githubusercontent.com/75303327/106884467-b1899700-6724-11eb-8181-5d82a555331b.gif)

* エラーメッセージの日本語化
  - 情報入力に失敗すると、日本語のエラーメッセージが表示されます。
  
  ![jaerrors2](https://user-images.githubusercontent.com/75303327/106884929-48eeea00-6725-11eb-8ba9-3bb3a7489cb6.gif)


# 実装予定の機能
* 結合テストコードの完成
* メニューバーのページを追加
* 複数枚画像投稿機能
* クレジットカード寄付機能


# DB計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ |-------- | ------------------------- |
| role               | integer | null: false               |
| name               | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| birthday           | date    | null: false               |
| occupation         | string  | null: false               |
| profile            | text    |                           |

### Association

- has_many :contents
- has_many :comments, dependent: :destroy
- has_many :favorites, dependent: :destroy

## contents テーブル

| Column        | Type       | Options                        |
| ------------- |----------- | ------------------------------ |
| title         | string     | null: false                    |
| image_content | string     |                                |
| video_content | string     |                                |
| overview      | text       | null: false                    |
| writing       | text       | null: false                    |
| source        | string     | null: false                    |
| user          | references | null: false, foreign_key: true |
| category      | references | null: false, foreign_key: true |

### Association

- has_many :comments, dependent: :destroy
- has_many :favorites, dependent: :destroy
- belongs_to :user
- belongs_to :category

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| text    | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| content | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :content

## favorites テーブル

| Column  | Type       | Options                        |
| ------- |----------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| content | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :content

## categories テーブル

| Column   | Type   | Options     |
| -------- |------- | ----------- |
| name     | string | null: false |
| ancestry | string | index: true |

### Association

- has_many :contents
- has_ancestry

## ER図
  <img width="480" src="https://user-images.githubusercontent.com/75303327/106885546-172a5300-6726-11eb-8c66-3bb90e90c623.png">


# ローカルでの動作方法
* 開発環境
  - Ruby2.6.5 / Ruby on Rails6.0.3.4 / MySQL5.6.50 / GitHub2.24.3 / S3(AWS) / Heroku7.47.11 / Visual Studio Code / Trello

* git cloneから、ローカルで動作させるまでに必要なコマンド
```
% git clone <リモートリポジトリのURL>
```
```
% cd アプリケーションのディレクトリ
```
```
% bundle install
```
```
% yarn install
```
```
% rails db:create
```
```
% rails db:migrate
```
```
% rails s
```

