# Harayan ドキュメント

## 概要
Harayan 企業サイト（Ruby on Rails 8.1 + Tailwind CSS v4）

**本番URL**: https://harayan.onrender.com/

---

## 現在のドキュメント

### クライアント確認用
| ファイル | 説明 |
|---------|------|
| [client-confirmation-checklist.md](./client-confirmation-checklist.md) | 公開前に確認が必要な全項目リスト |
| [client-confirmation-checklist.csv](./client-confirmation-checklist.csv) | ↑のスプレッドシート版（Google Sheets等にインポート可） |

### 外部連携
| ファイル | 説明 |
|---------|------|
| [instagram-feed-integration.md](./instagram-feed-integration.md) | Instagramフィード表示の方法比較・Graph API実装ガイド |

### インフラ
| ファイル | 説明 |
|---------|------|
| [infra/hosting.md](./infra/hosting.md) | ホスティング選定（Render採用） |
| [infra/deployment.md](./infra/deployment.md) | デプロイ手順 |

### 開発計画
| ファイル | 説明 |
|---------|------|
| [renovation-plan-v2.md](./renovation-plan-v2.md) | 現在の改修計画（ヒアリングシート反映版） |

---

## サイト構成

```
/ (TOP)
├── /about          # 会社概要
├── /stores         # 店舗一覧
│   ├── /stores/8108      # 八十八（浅草・渋谷・鎌倉）
│   ├── /stores/a-kyoto   # A kyoto
│   └── /stores/b-kyoto   # B kyoto
├── /business       # 事業内容
├── /recruit        # 採用情報
└── /contact        # お問い合わせ
```

---

## 技術スタック
- Ruby 3.3.2 / Rails 8.1（DB無し）
- Tailwind CSS v4
- Turbo + Stimulus
- Propshaft（アセット管理）
- Render（ホスティング）

---

## デザインルール

**CLAUDE.md に記載**（このファイルがデザインシステムの正）

- カラー: ホワイトベース + グレー + ダークアクセント
- フォント: Inter + Noto Sans JP
- レイアウト: シンプルカジュアル、余白多め

---

## 旧ドキュメント

以下は過去のドキュメントです（参考用に保持）:

```
_archive/
├── pages/           # 旧ページ仕様
├── design/          # 旧デザインシステム
├── implementation.md # 旧実装計画
└── logs/            # 旧作業ログ
```

---

## クイックリンク

- [CLAUDE.md](../CLAUDE.md) - プロジェクトルール・デザインシステム
- [GitHub Actions](.github/workflows/) - CI設定
- [本番サイト](https://harayan.onrender.com/)
