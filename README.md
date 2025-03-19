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
6. [セットアップ (Getting Started)](#セットアップ-getting-started)
7. [デプロイ (Deployment)](#デプロイ-deployment)
8. [ライセンス (License)](#ライセンス-license)
9. [その他 (補足情報)](#その他-補足情報)

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

<img width="600" alt="ER Diagram" src="https://github.com/user-attachments/assets/af08e900-5f9d-421b-8695-169912dbb560" />

- **Admin** と **Customer**：Deviseでログイン管理
- **Product**：ECサイトの商品
- **CartItem**：顧客のカート内アイテム
- **Order** / **OrderDetail**：注文＆注文明細

---

## 使用技術 (Tech Stack)
- **言語・フレームワーク**: Ruby 3.3.4, Rails 7.2.0
- **認証**: Devise
- **コンテナ**: Docker, Docker Compose
- **データベース**: PostgreSQL (開発・本番)
- **画像ストレージ**: Active Storage + Cloudinary
- **ジョブ管理**: Sidekiq + Redis
- **ホスティング**: Heroku
- **フロントエンド**: Tailwind CSS, Stimulus (Rails 7標準構成)

---

## セットアップ (Getting Started)

### 1. リポジトリをクローン
```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
