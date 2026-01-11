# コンタクトフォーム改修計画

## 現状
- HTMLフォーム（プレースホルダー）が配置済み
- フォーム送信機能は未実装
- DBなし（`--skip-active-record`で構築）

## 目標
- DBを使わずにフォーム送信を実現
- 問い合わせデータを蓄積
- 新着問い合わせを即時通知

## 構成案

```
┌─────────────────────────────────────────────────────────┐
│                    ユーザー                              │
│                       │                                 │
│                       ▼                                 │
│              お問い合わせフォーム                         │
│                       │                                 │
│                       ▼                                 │
│              ContactsController                         │
│                       │                                 │
│          ┌───────────┴───────────┐                     │
│          ▼                       ▼                     │
│   Google Sheets API        Slack Webhook               │
│   （データ蓄積）           （即時通知）                   │
└─────────────────────────────────────────────────────────┘
```

## フォーム項目

| 項目 | 必須 | 型 |
|------|------|-----|
| お名前 | ✅ | テキスト |
| メールアドレス | ✅ | Email |
| 電話番号 | - | Tel |
| お問い合わせ種別 | ✅ | セレクト |
| お問い合わせ内容 | ✅ | テキストエリア |

### お問い合わせ種別の選択肢
- 一般的なお問い合わせ
- サービスについて
- 採用について
- その他

## 技術要件

### 1. Google Sheets API
- **目的**: 問い合わせデータの永続化
- **認証**: サービスアカウント（JSON鍵ファイル）
- **Gem**: `google-apis-sheets_v4`

### 2. Slack Webhook
- **目的**: 新着問い合わせの即時通知
- **認証**: Incoming Webhook URL（環境変数）
- **実装**: `Net::HTTP`でPOST
- **料金**: 無料（Slack Free プランでOK）

### 3. 環境変数
```bash
# .env（gitignore済み）
GOOGLE_SHEETS_SPREADSHEET_ID=xxxxx
GOOGLE_SHEETS_CREDENTIALS=credentials.json  # または Base64エンコード
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/xxxxx/xxxxx/xxxxx
```

## 実装手順

### Phase 1: 基盤準備
- [ ] `google-apis-sheets_v4` gem追加
- [ ] 環境変数の設定（dotenv-rails）
- [ ] Googleサービスアカウント作成
- [ ] スプレッドシート作成・共有設定

### Phase 2: コントローラー実装
- [ ] `ContactsController#create` 作成
- [ ] ルーティング追加（`POST /contact`）
- [ ] Google Sheets書き込み処理
- [ ] Slack通知処理

### Phase 3: ビュー更新
- [ ] フォームのaction属性を更新
- [ ] CSRFトークン追加
- [ ] 送信完了メッセージ（flash）
- [ ] バリデーションエラー表示

### Phase 4: テスト
- [ ] コントローラースペック追加
- [ ] システムスペック更新
- [ ] 外部API呼び出しのモック

## Google設定手順

### Google Cloud Console
1. プロジェクト作成
2. Google Sheets API 有効化
3. サービスアカウント作成
4. JSON鍵ファイルをダウンロード

### Google Sheets
1. スプレッドシート作成
2. ヘッダー行追加（日時, 名前, メール, 電話, 種別, 内容）
3. サービスアカウントのメールを編集者として共有

### Slack Webhook
1. [Slack API](https://api.slack.com/apps) でアプリ作成
2. 「Incoming Webhooks」を有効化
3. 「Add New Webhook to Workspace」でチャンネル選択
4. Webhook URLをコピー

## バリデーション仕様

### 必須項目
| 項目 | 必須 | エラーメッセージ |
|------|------|-----------------|
| お名前 | ✅ | 「お名前を入力してください」 |
| メールアドレス | ✅ | 「メールアドレスを入力してください」 |
| 電話番号 | ❌ | - |
| お問い合わせ種別 | ✅ | 「お問い合わせ種別を選択してください」 |
| お問い合わせ内容 | ✅ | 「お問い合わせ内容を入力してください」 |

### メールアドレス形式
```ruby
/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
```
| 入力例 | 結果 |
|--------|------|
| `test@example.com` | ✅ |
| `test.name+tag@example.co.jp` | ✅ |
| `invalid-email` | ❌ |
| `test@` | ❌ |

### 電話番号形式（任意項目、入力時のみチェック）
```ruby
# ハイフン・スペース除去後、10-11桁の数字
/\A\d{10,11}\z/
```
| 入力例 | 結果 |
|--------|------|
| `09012345678` | ✅ |
| `090-1234-5678` | ✅ |
| `03-1234-5678` | ✅ |
| `12345` | ❌（短すぎ） |
| `abc-1234` | ❌（文字含む） |

### エラー時の動作
- バリデーションエラーは赤いフラッシュメッセージで表示
- 入力値は保持される（再入力不要）
- HTTPステータス: 422 Unprocessable Entity

## セキュリティ考慮事項
- [ ] CSRF対策（Rails標準）
- [ ] レートリミット（Rack::Attack等）
- [ ] 入力値のサニタイズ
- [ ] 環境変数の管理（本番環境）

## 代替案

### A. Google Sheets のみ（通知なし）
- シンプルな実装
- 定期的にシートを確認する運用

### B. Slack のみ（蓄積なし）
- 最もシンプル
- データは流れていく

### C. メール送信のみ
- Action Mailer使用
- SMTPサーバー設定必要

### D. 他の通知先
- Discord Webhook
- LINE Notify
- Google Chat（Google Workspace必要）

## 参考リンク
- [Google Sheets API v4](https://developers.google.com/sheets/api/guides/concepts)
- [Slack Incoming Webhooks](https://api.slack.com/messaging/webhooks)
- [google-apis-ruby-client](https://github.com/googleapis/google-api-ruby-client)
