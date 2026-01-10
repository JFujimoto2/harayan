# Harayan

企業/サービスサイト

## 技術スタック

- Ruby 3.3.2
- Rails 8.1
- Tailwind CSS v4
- RSpec

## セットアップ

```bash
# 依存関係インストール
bundle install

# 開発サーバー起動（Tailwind自動ビルド）
bin/dev
```

http://localhost:3000 でアクセス

## ページ構成

| パス | ページ |
|-----|--------|
| `/` | トップページ |
| `/about` | 会社概要 |
| `/shops` | 店舗情報 |
| `/recruit` | 採用情報 |
| `/contact` | お問い合わせ |

## 開発

```bash
# テスト実行
bundle exec rspec

# Lint
bin/rubocop
```

## ブランチ戦略

GitHub Flow を採用。詳細は [CLAUDE.md](./CLAUDE.md) を参照。

- `main` - 本番用（保護済み）
- `feature/*` - 新機能
- `fix/*` - バグ修正
- `chore/*` - 設定変更
