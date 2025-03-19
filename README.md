# Rails + Docker EC App

このリポジトリは、**Ruby on Rails** で構築された簡易的なECサイトのサンプルアプリケーションです。  
**Docker** および **Docker Compose** を利用してローカル開発が行えるほか、**Heroku** へのデプロイにも対応しています。

本番環境デモ（Heroku）:  
[https://stormy-gorge-33057-aca6953c3324.herokuapp.com/](https://stormy-gorge-33057-aca6953c3324.herokuapp.com/)

---

## 目次
1. [概要 (Overview)](#概要-overview)
2. [主な機能 (Key Features)](#主な機能-key-features)
3. [画面イメージ (Screenshots)](#画面イメージ-screenshots)
4. [ER図](#er図)
5. [使用技術 (Tech Stack)](#使用技術-tech-stack)
6. [ライセンス (License)](#ライセンス-license)

---

## 概要 (Overview)
- **Rails 7.2.0** / **Ruby 3.3.4**
- **Docker + Docker Compose** でローカル実行可能
- **Heroku** へのデプロイ設定済み
- 画像アップロードは **Cloudinary** と **Active Storage** を利用
- 認証機能に **Devise** を採用し、管理者(`Admin`) と顧客(`Customer`)の2種類のユーザーモデルを扱う
- 非同期ジョブに **Sidekiq** を利用可能（`sidekiq.rb`, `sidekiq.yml` 参照）
- フロントエンドには **Tailwind CSS** を適宜活用

---

## 主な機能 (Key Features)

### 1. 管理者機能
- **商品管理**：`/admin/products`
  - 商品一覧・詳細・作成・編集・削除
  - 商品画像アップロード（Cloudinary）
- **ユーザー管理**：`/admin/customers`
  - 顧客一覧・詳細・ステータス管理
- **受注管理**：`/admin/orders`
  - 受注の一覧・詳細確認
- **ログイン/ログアウト**  
  - Deviseを用いた管理者専用ログイン (`/admin/sign_in`)

### 2. 顧客（ECサイト）機能
- **トップページ**：登録された商品一覧を閲覧可能
- **商品詳細ページ**
- **カート機能**：商品をカートに入れて、カート内一覧を確認できる
- **受注・注文履歴**：ダミーの決済フロー（実際の決済は行わない）
- **顧客アカウント**：`/customers/sign_in`
  - 新規登録、ログイン/ログアウト
  - パスワードリセットやアカウント編集

### 3. その他
- **メール送信**：注文完了時のメール通知 (Action Mailer + SMTP設定)
- **Active Storage + Cloudinary**：画像のホスト管理
- **Docker** による開発環境の簡易構築
- **Heroku** デプロイ用の設定 (Procfile, Gemfileなど)

---

## 画面イメージ (Screenshots)

| Products 一覧 (管理者)                                                | トップページ (顧客)                                                 |
|-----------------------------------------------------------------------|----------------------------------------------------------------------|
| ![Product List](https://github.com/user-attachments/assets/b817adff-f0e5-430a-985a-39d1cd09f989) | ![TOP Page](https://github.com/user-attachments/assets/bdbb12c1-e59a-4499-82ea-1e45d79f95ca) |

---

## ER図
<img width="741" alt="Screenshot 2025-03-19 at 11 45 23" src="https://github.com/user-attachments/assets/d5447eba-916f-4f2a-ac26-b29b4e10a79e" />

### 1. Admins
Devise により **管理者ログイン機能** を提供するテーブル

- **主なカラム:**
  - `email`: 管理者のメールアドレス
  - `encrypted_password`: パスワード（暗号化済）
  - `reset_password_token`: パスワードリセット用のトークン
  - `reset_password_sent_at`: パスワードリセットリクエスト時刻
  - `remember_created_at`: ログイン状態の記録
- **リレーション:** 他のテーブルとの FK 関係なし

### 2. Customers
Devise により **顧客ログイン機能** を提供するテーブル

- **主なカラム:**
  - `email`: 顧客のメールアドレス
  - `encrypted_password`: パスワード（暗号化済）
  - `name`: 顧客の名前
  - `status`: ステータス管理（有効 / 退会 など）
- **リレーション:**
  - `CartItems`（1対多） → **顧客は複数の商品をカートに入れる**
  - `Orders`（1対多） → **顧客は複数の注文を行う**

### 3. Products
ECサイトで扱う **商品のマスタ情報** を保持するテーブル

- **主なカラム:**
  - `name`: 商品名
  - `description`: 商品説明
  - `price`: 価格
  - `stock`: 在庫数
- **リレーション:**
  - `CartItems`（1対多） → **商品はカートに追加される**
  - `OrderDetails`（1対多） → **商品は注文される**

### 4. CartItems
ユーザー（顧客）がカートに入れた商品を管理する **中間テーブル**

- **主なカラム:**
  - `quantity`: 商品の個数
  - `customer_id`: **Customers** との FK
  - `product_id`: **Products** との FK
- **リレーション:**
  - `Customers`（多対1） → **顧客ごとのカート情報**
  - `Products`（多対1） → **カートに追加された商品情報**

### 5. Orders
**注文情報** を管理するマスタテーブル

- **主なカラム:**
  - `name`: 配送先の名前
  - `postal_code`: 郵便番号
  - `prefecture`: 都道府県
  - `address1`: 市区町村
  - `address2`: 詳細住所
  - `postage`: 配送料
  - `billing_amount`: 合計請求額
  - `status`: 注文のステータス（処理中、発送済み など）
  - `customer_id`: **Customers** との FK
- **リレーション:**
  - `Customers`（多対1） → **注文を行った顧客**
  - `OrderDetails`（1対多） → **注文の詳細情報**

### 6. OrderDetails
注文ごとの **明細情報** を管理するテーブル（どの商品を何個、いくらで買ったか）

- **主なカラム:**
  - `price`: 購入時の価格（注文時の価格を保存）
  - `quantity`: 購入個数
  - `order_id`: **Orders** との FK
  - `product_id`: **Products** との FK
- **リレーション:**
  - `Orders`（多対1） → **注文に紐づく詳細情報**
  - `Products`（多対1） → **購入された商品**

---

### 使用技術 (Tech Stack)
- **言語・フレームワーク**: Ruby 3.3.4, Rails 7.2.0
- **認証**: Devise
- **コンテナ**: Docker, Docker Compose
- **データベース**: PostgreSQL (開発・本番)
- **画像ストレージ**: Active Storage + Cloudinary
- **ジョブ管理**: Sidekiq + Redis
- **ホスティング**: Heroku
- **フロントエンド**: Tailwind CSS, Stimulus (Rails 7標準構成)

---

## **ライセンス (License)**
このプロジェクトは **MIT License** のもとで公開されています。  
詳細は [`LICENSE`](./LICENSE) ファイルを参照してください。

