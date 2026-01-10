# Harayan ドキュメント

## 概要
企業/サービスサイト（Ruby on Rails）

## ドキュメント構成

```
docs/
├── README.md          # このファイル
├── implementation.md  # 実装計画
├── pages/             # 各ページ仕様
│   ├── home.md
│   ├── about.md
│   ├── shops.md
│   ├── recruit.md
│   └── contact.md
├── design/            # デザインシステム
│   ├── README.md
│   ├── colors.md
│   ├── typography.md
│   ├── components.md
│   └── layout.md
└── logs/              # 実装ログ
    ├── README.md
    ├── progress.md    # 進捗チェックリスト
    └── history/       # 日別作業ログ
        └── YYYY-MM-DD.md
```

## 技術スタック
- Ruby 3.3.2
- Rails 8.1（DB無し）
- Tailwind CSS v4
- Turbo + Stimulus
- Propshaft（アセット管理）
