# 実装進捗

## Phase 1: 環境構築
- [x] Rails 8.1 プロジェクト作成
- [x] Tailwind CSS 導入
- [x] カスタムテーマ設定（カラー、フォント）
- [x] Google Fonts 設定
- [x] GitHub リポジトリ作成

## Phase 2: 共通コンポーネント
- [x] レイアウト（`application.html.erb`）
- [x] ヘッダー（`_header.html.erb`）
- [x] フッター（`_footer.html.erb`）
- [x] モバイルメニュー（Stimulus）

## Phase 3: ルーティング・コントローラー
- [x] ルーティング設定（`config/routes.rb`）
- [x] PagesController 作成

## Phase 4: ページ実装
- [x] トップページ（`home.html.erb`）
  - [x] ヒーローセクション
  - [x] コンセプトセクション
  - [x] サービス紹介カード
- [x] About（`about.html.erb`）
  - [x] 会社理念
  - [x] 会社概要テーブル
- [x] 店舗情報（`shops.html.erb`）
  - [x] 店舗カード
  - [x] Googleマップ埋め込み（仮: 東京駅）
- [x] 採用情報（`recruit.html.erb`）
  - [x] 求める人物像
  - [x] 募集要項
- [x] コンタクト（`contact.html.erb`）
  - [x] お問い合わせフォーム（HTMLフォーム）

## Phase 5: 画像・アセット
- [x] ダミー画像配置（CSSグラデーションで代用）
- [ ] 実際の画像に差し替え

## Phase 6: 最終確認
- [x] 全ページ動作確認（HTTP 200）
- [x] RSpecテスト（31件パス）
- [x] CI設定（GitHub Actions）
- [ ] レスポンシブ確認（ブラウザで確認推奨）
- [ ] 実際のテキスト・情報に差し替え

## Phase 7: 本番準備
- [ ] 実際の店舗住所でGoogleマップ更新
- [ ] Googleフォームに差し替え（必要なら）
- [ ] 本番ドメイン設定
- [ ] デプロイ
