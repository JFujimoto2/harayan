# デザインシステム

## 概要
Tailwind CSS v4を使用したデザインシステム

## 技術スタック
- **Tailwind CSS v4** - ユーティリティファーストCSS
- **Work Sans** - 英語フォント
- **Noto Sans JP** - 日本語フォント

## ファイル構成
```
app/assets/tailwind/
└── application.css    # Tailwind設定・カスタムテーマ

app/views/
├── layouts/
│   └── application.html.erb  # 基本レイアウト
└── shared/
    ├── _header.html.erb      # ヘッダー
    └── _footer.html.erb      # フッター

app/javascript/controllers/
└── mobile_menu_controller.js # モバイルメニュー
```

## ドキュメント
- [colors.md](./colors.md) - カラーパレット
- [typography.md](./typography.md) - タイポグラフィ
- [components.md](./components.md) - UIコンポーネント
- [layout.md](./layout.md) - レイアウト

## 開発コマンド
```bash
# 開発サーバー起動（Tailwind自動ビルド付き）
bin/dev

# Tailwindを手動ビルド
rails tailwindcss:build

# Tailwindをウォッチモードでビルド
rails tailwindcss:watch
```
