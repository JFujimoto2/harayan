# デプロイ計画

## 概要
HarayanサイトをWebに公開するためのデプロイ設定

## 技術要件
- Ruby on Rails 8.1
- DBなし（`--skip-active-record`）
- 環境変数による設定管理
- SSL対応

## デプロイ先の比較

| サービス | 無料枠 | スリープ | 自動デプロイ | カスタムドメイン | SSL |
|---------|--------|----------|-------------|----------------|-----|
| **Render** | ✅ | 15分で休止 | ✅ GitHub連携 | ✅ | ✅ 自動 |
| **Fly.io** | ✅ | なし | ✅ CLI | ✅ | ✅ 自動 |
| **Railway** | $5/月無料枠 | なし | ✅ GitHub連携 | ✅ | ✅ 自動 |
| Heroku | ❌ 有料 | - | ✅ | ✅ | ✅ |

### 推奨: Render
- 設定が簡単
- GitHub連携で自動デプロイ
- 無料枠で十分（小規模サイト）
- 15分アクセスなしでスリープ（初回アクセス時に起動、数秒かかる）

---

## Render デプロイ手順

### Phase 1: Render設定

#### 1.1 アカウント作成
1. https://render.com/ にアクセス
2. GitHubアカウントでサインアップ

#### 1.2 新規Webサービス作成
1. Dashboard → 「New +」→「Web Service」
2. GitHubリポジトリを接続（JFujimoto2/harayan）
3. 以下を設定:

| 項目 | 値 |
|------|-----|
| Name | `harayan` |
| Region | `Singapore (Southeast Asia)` |
| Branch | `main` |
| Runtime | `Ruby` |
| Build Command | `bundle install && bin/rails tailwindcss:build` |
| Start Command | `bin/rails server -b 0.0.0.0` |
| Instance Type | `Free` |

### Phase 2: 環境変数設定

Render Dashboard → Environment で以下を設定:

```bash
# Rails
RAILS_ENV=production
SECRET_KEY_BASE=<生成する>
RAILS_SERVE_STATIC_FILES=true

# Slack
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/xxxxx

# Google Sheets
GOOGLE_SHEETS_SPREADSHEET_ID=xxxxx
GOOGLE_SHEETS_CREDENTIALS_JSON=<JSON内容をBase64エンコード>
```

#### SECRET_KEY_BASEの生成
```bash
bin/rails secret
```

#### Google認証情報のBase64エンコード
```bash
base64 -w 0 config/google_credentials.json
```

### Phase 3: アプリケーション修正

#### 3.1 本番用Google認証対応
環境変数からJSON認証情報を読み込む処理を追加

#### 3.2 Procfile作成（オプション）
```
web: bin/rails server -b 0.0.0.0 -p $PORT
```

#### 3.3 render.yaml作成（オプション）
```yaml
services:
  - type: web
    name: harayan
    runtime: ruby
    buildCommand: bundle install && bin/rails tailwindcss:build
    startCommand: bin/rails server -b 0.0.0.0
    envVars:
      - key: RAILS_ENV
        value: production
      - key: RAILS_SERVE_STATIC_FILES
        value: true
      - key: SECRET_KEY_BASE
        generateValue: true
```

### Phase 4: デプロイ実行

1. GitHubにプッシュ
2. Renderが自動でビルド・デプロイ
3. 数分後にURLでアクセス可能

### Phase 5: カスタムドメイン（オプション）

1. Render Dashboard → Settings → Custom Domain
2. ドメインを追加（例: `harayan.com`）
3. DNSレコードを設定:
   - CNAMEレコード: `harayan.onrender.com`
4. SSL証明書は自動発行

---

## Fly.io デプロイ手順（代替案）

### 1. CLIインストール
```bash
curl -L https://fly.io/install.sh | sh
```

### 2. ログイン
```bash
fly auth login
```

### 3. アプリ作成
```bash
fly launch
```

### 4. 環境変数設定
```bash
fly secrets set SLACK_WEBHOOK_URL=xxxxx
fly secrets set GOOGLE_SHEETS_SPREADSHEET_ID=xxxxx
fly secrets set GOOGLE_SHEETS_CREDENTIALS_JSON=xxxxx
```

### 5. デプロイ
```bash
fly deploy
```

---

## 実装チェックリスト

### 事前準備
- [ ] デプロイ先サービスの選定
- [ ] アカウント作成

### アプリケーション修正
- [ ] 本番用Google認証情報の読み込み対応
- [ ] Procfile作成（必要に応じて）
- [ ] render.yaml作成（必要に応じて）

### デプロイ設定
- [ ] サービス作成
- [ ] GitHubリポジトリ連携
- [ ] 環境変数設定
- [ ] ビルド・起動コマンド設定

### デプロイ後確認
- [ ] サイトにアクセスできる
- [ ] 全ページ表示確認
- [ ] お問い合わせフォーム送信テスト
- [ ] Google Sheetsにデータ追加確認
- [ ] Slack通知確認

### オプション
- [ ] カスタムドメイン設定
- [ ] SSL証明書確認

---

## 注意事項

### 無料枠の制限（Render）
- 15分アクセスなしでスリープ
- 月750時間まで（1インスタンスなら十分）
- 初回アクセス時に起動で数秒〜30秒かかる

### 環境変数のセキュリティ
- 本番環境ではダッシュボードから設定
- `.env`ファイルは本番にデプロイしない
- Google認証情報はBase64エンコードで環境変数化

### Google Sheets認証（本番対応）
開発環境ではファイル、本番では環境変数から読み込む:
```ruby
if ENV['GOOGLE_SHEETS_CREDENTIALS_JSON'].present?
  # 本番: 環境変数からJSON読み込み
  json_key = Base64.decode64(ENV['GOOGLE_SHEETS_CREDENTIALS_JSON'])
  credentials = Google::Auth::ServiceAccountCredentials.make_creds(
    json_key_io: StringIO.new(json_key),
    scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS
  )
else
  # 開発: ファイルから読み込み
  credentials = Google::Auth::ServiceAccountCredentials.make_creds(
    json_key_io: File.open(ENV['GOOGLE_SHEETS_CREDENTIALS']),
    scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS
  )
end
```

---

## 参考リンク
- [Render - Rails Deployment](https://render.com/docs/deploy-rails)
- [Fly.io - Rails Getting Started](https://fly.io/docs/rails/getting-started/)
- [Railway - Rails Deployment](https://docs.railway.app/guides/rails)
