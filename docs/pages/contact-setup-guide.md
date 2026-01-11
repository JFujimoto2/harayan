# お問い合わせフォーム セットアップガイド

本番環境用に新しく設定する場合の手順書です。

---

## 1. Slack Webhook 設定

### 1.1 Slackワークスペースの準備
- 既存のワークスペースを使用、または新規作成
- 通知用チャンネルを作成（例: `#お問い合わせ`）

### 1.2 Slack App 作成
1. https://api.slack.com/apps にアクセス
2. 「Create New App」→「From a manifest」を選択
3. ワークスペースを選択
4. 以下のYAMLを貼り付け:

```yaml
display_information:
  name: Harayan通知
features:
  bot_user:
    display_name: harayan-bot
    always_online: false
oauth_config:
  scopes:
    bot:
      - incoming-webhook
settings:
  org_deploy_enabled: false
```

5. 「Create」をクリック
6. 「Install to Workspace」→ チャンネル選択 →「許可する」
7. 左メニュー「Incoming Webhooks」でWebhook URLをコピー

### 1.3 環境変数に設定
```bash
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/XXXXX/XXXXX/XXXXX
```

### 1.4 動作確認
```bash
bin/rails slack:test
```

---

## 2. Google Sheets API 設定

### 2.1 Google Cloud プロジェクト作成
1. https://console.cloud.google.com/ にアクセス
2. 「プロジェクトを選択」→「新しいプロジェクト」
3. プロジェクト名を入力（例: `harayan-contact-prod`）
4. 「作成」

### 2.2 Google Sheets API 有効化
1. 左メニュー「APIとサービス」→「ライブラリ」
2. 「Google Sheets API」を検索
3. 「有効にする」

### 2.3 サービスアカウント作成
1. 左メニュー「APIとサービス」→「認証情報」
2. 「認証情報を作成」→「サービスアカウント」
3. 名前を入力（例: `harayan-sheets`）
4. 「完了」

### 2.4 JSON鍵ファイル取得
1. 作成したサービスアカウントをクリック
2. 「キー」タブ →「鍵を追加」→「新しい鍵を作成」
3. 「JSON」→「作成」
4. ダウンロードされたファイルを `config/google_credentials.json` に保存

**重要**: このファイルは `.gitignore` に含まれていること

### 2.5 スプレッドシート作成
1. https://docs.google.com/spreadsheets/ で新規作成
2. 1行目にヘッダーを入力:

| A | B | C | D | E | F |
|---|---|---|---|---|---|
| 日時 | お名前 | メールアドレス | 電話番号 | お問い合わせ種別 | お問い合わせ内容 |

3. スプレッドシートのURLからIDを取得:
   ```
   https://docs.google.com/spreadsheets/d/【このIDをコピー】/edit
   ```

### 2.6 サービスアカウントに共有
1. スプレッドシートの「共有」をクリック
2. JSON鍵ファイル内の `client_email` の値を追加
   ```
   例: harayan-sheets@project-id.iam.gserviceaccount.com
   ```
3. 権限: 「編集者」
4. 「送信」

### 2.7 環境変数に設定
```bash
GOOGLE_SHEETS_SPREADSHEET_ID=スプレッドシートのID
GOOGLE_SHEETS_CREDENTIALS=config/google_credentials.json
```

### 2.8 動作確認
```bash
bin/rails google_sheets:test
```

---

## 3. 環境変数一覧

### .env ファイル（ローカル開発用）
```bash
# Slack Webhook
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/XXXXX/XXXXX/XXXXX

# Google Sheets API
GOOGLE_SHEETS_SPREADSHEET_ID=XXXXX
GOOGLE_SHEETS_CREDENTIALS=config/google_credentials.json
```

### 本番環境
本番環境では、ホスティングサービスの環境変数設定を使用:
- Heroku: `heroku config:set`
- Render: Dashboard → Environment
- Fly.io: `fly secrets set`

**注意**: `google_credentials.json` の内容は、本番環境では環境変数としてBase64エンコードして渡すか、シークレット管理サービスを使用することを推奨

---

## 4. テストコマンド

```bash
# Slack通知テスト
bin/rails slack:test

# Google Sheets書き込みテスト
bin/rails google_sheets:test
```

---

## 5. トラブルシューティング

### Slack: 「ボットユーザーがありません」エラー
→ App Home でBot Display Nameを設定する

### Google Sheets: 403 Forbidden
→ スプレッドシートがサービスアカウントに共有されているか確認

### Google Sheets: 認証エラー
→ `config/google_credentials.json` のパスと内容を確認

---

## 6. セキュリティチェックリスト

- [ ] `.env` が `.gitignore` に含まれている
- [ ] `config/google_credentials.json` が `.gitignore` に含まれている
- [ ] Webhook URLが外部に漏れていない
- [ ] スプレッドシートの共有設定が「リンクを知っている全員」になっていない
