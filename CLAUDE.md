# Harayan プロジェクトルール

## プロジェクト概要
- 企業/サービスサイト（Ruby on Rails 8.1）
- Tailwind CSS v4 使用
- DB無し（`--skip-active-record`）

## 実装ログのルール

### 進捗管理（docs/logs/progress.md）
- タスク完了時に該当項目を `[x]` に更新する
- 新しいタスクが発生したら追加する
- Phaseごとに整理して管理する

### 作業履歴（docs/logs/history/YYYY-MM-DD.md）
- 日付ごとにファイルを作成する
- 実施内容を記録する
- 次のタスクを明記する
- 重要なメモや決定事項を残す

### 更新タイミング
1. **実装開始時**: 今日の履歴ファイルを作成/更新
2. **タスク完了時**: progress.md のチェックを更新
3. **作業終了時**: 履歴ファイルに「次のタスク」を記載

## ドキュメント構成

```
docs/
├── implementation.md  # 実装計画
├── pages/             # 各ページ仕様
├── design/            # デザインシステム（Tailwind）
└── logs/              # 実装ログ
    ├── progress.md    # 進捗チェックリスト
    └── history/       # 日別作業ログ
```

## CI/テストルール

- **コミット前**: `bundle exec rspec` でテストがパスすることを確認
- **プッシュ後**: GitHub Actions のCIが通ることを確認してから次のタスクに進む
- **CI失敗時**: 原因を調査・修正し、CIが通るまで他の作業に進まない

## 開発コマンド

```bash
# 開発サーバー起動（Tailwind自動ビルド）
bin/dev

# 通常のRailsサーバー
rails server

# Tailwind手動ビルド
rails tailwindcss:build
```

## コーディング規約

### ビュー（ERB）
- Tailwind CSSのユーティリティクラスを使用
- 共通パーツは `app/views/shared/` にパーシャル化
- コンポーネント例は `docs/design/components.md` を参照

### カラー
- Primary（深緑）: `primary-500` 〜 `primary-700`
- Accent（ブラウン）: `accent-500` 〜 `accent-600`
- 詳細は `docs/design/colors.md` を参照
