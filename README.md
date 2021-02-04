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
* コンテンツ閲覧方法
  - 一覧に表示されたコンテンツの画像または動画、タイトル、概要をクリックしていただくと、コンテンツの詳細ページがご覧いただけます。
* 確認後、ログアウト処理をお願いいたします。


# 目指した課題解決

中学生くらいの年齢の学生さんの、将来への関心ごとを広げられるように、好きなことや興味を見つけてもらう、また、楽しんでもらうために、このアプリケーションを実装いたしました。
また、実際にお仕事をされている方々にコンテンツを投稿してもらうことで、将来への視野が広がることを理想としています。

# 洗い出した要件（要件定義をマークダウン）
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
  - Cancancanを用いて、仕事ユーザーにはコンテンツが投稿できる権限を付与しました。仕事ユーザーがログインすると、画面右の少し上に、「New content!」というリンクがありますが、学生がログインした時にはリンクがありません。
![userauth7](https://user-images.githubusercontent.com/75303327/106876112-b9443e00-671a-11eb-857f-0ffb83c6a9ce.gif)

* コンテンツ投稿・編集・削除機能
* コンテンツ一覧表示機能
* ユーザー詳細（マイページ）表示機能
* コメント投稿機能
* カテゴリー検索機能
* いいねボタン機能
* エラーメッセージの日本語化

# 実装予定の機能
* 結合テストコード
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

# ローカルでの動作方法
* 開発環境
  - Ruby2.6.5 / Ruby on Rails6.0.3.4 / MySQL5.6.50 / GitHub2.24.3 / S3(AWS) / Heroku7.47.11 / Visual Studio Code / Trello

