# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ |-------- | ------------------------- |
| role               | integer | null: false               |
| name               | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| birthday           | date    | null: false               |
| occupation         | text    | null: false               |

### Association

- has_many :contents
- has_many :comments, dependent: :destroy
- has_many :favorites, dependent: :destroy
- has_many :donations

## contents テーブル

| Column      | Type       | Options                        |
| ----------- |----------- | ------------------------------ |
| title       | string     | null: false                    |
| overview    | text       | null: false                    |
| writing     | text       | null: false                    |
| source      | string     | null: false                    |
| user        | references | null: false, foreign_key: true |
| category    | references | null: false, foreign_key: true |

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

| Column   | Type   | Options                  |
| -------- |------- | ------------------------ |
| name     | string | null: false              |
| ancestry | string | null: false, index: true |

### Association

- has_many :contents

## donations テーブル

| Column | Type       | Options                        |
| ------ |----------- | ------------------------------ |
| price  | string     | null: false                    |
| user   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one individual

## individuals テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| last_name       | string     | null: false                    |
| first_name      | string     | null: false                    |
| last_name_kana  | string     | null: false                    |
| first_name_kana | string     | null: false                    |
| postal_code     | string     | null: false                    |
| prefecture      | integer    | null: false                    |
| city            | string     | null: false                    |
| house_number    | string     | null: false                    |
| building_name   | string     |                                |
| phone_number    | string     | null: false                    |
| donation        | references | null: false, foreign_key: true |

### Association

- belongs_to :donation



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
