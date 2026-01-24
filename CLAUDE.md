# Harayan プロジェクトルール

## プロジェクト概要
- 企業/サービスサイト（Ruby on Rails 8.1）
- Tailwind CSS v4 使用
- DB無し（`--skip-active-record`）
- **本番URL**: https://harayan.onrender.com/

---

## デザイン方針

### コンセプト
- **シンプル・カジュアル**なデザイン
- **20代〜30代が働きたいと思える**モダンな雰囲気
- 「お客様に寄り添う」がブランドコンセプト
- 参考サイト: https://andsupply.co/

---

### カラーパレット

```css
/* app/assets/stylesheets/application.css */
:root {
  /* 背景系 - ホワイトベース */
  --background: #ffffff;           /* メイン背景 */
  --background-secondary: #fafafa; /* セカンダリ背景 */
  --muted: #f5f5f5;                /* カード背景など */

  /* テキスト系 */
  --foreground: #1a1a1a;           /* メインテキスト - ほぼ黒 */
  --muted-foreground: #666666;     /* 補助テキスト - グレー */

  /* アクセント - 各店舗/事業で変更可能 */
  --primary: #1a1a1a;              /* デフォルトは黒 */

  /* ボーダー */
  --border: #e5e5e5;
  --border-light: #f0f0f0;
}
```

**使用ルール:**
- 背景: ホワイト基調（`#ffffff`, `#fafafa`）
- テキスト: 黒〜グレー（`#1a1a1a`, `#666666`）
- アクセント: 将来的に各店舗/事業でカスタマイズ可能
- **シンプルに白黒ベースを維持**

---

### タイポグラフィ

```erb
<%# app/views/layouts/application.html.erb の <head> に追加 %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&family=Noto+Sans+JP:wght@300;400;500;600&display=swap" rel="stylesheet">
```

```css
/* フォント定義 */
:root {
  --font-sans: 'Inter', 'Noto Sans JP', sans-serif;
}

/* 全体にサンセリフで統一（モダン・カジュアル） */
body {
  font-family: var(--font-sans);
  line-height: 1.6;
  font-size: 16px;
  font-weight: 400;
  color: #1a1a1a;
}

h1, h2, h3 {
  font-family: var(--font-sans);
  font-weight: 600;
  letter-spacing: -0.02em;
}

/* フォントサイズ */
h1 { font-size: 2.5rem; }    /* 40px */
h2 { font-size: 1.75rem; }   /* 28px */
h3 { font-size: 1.25rem; }   /* 20px */
p  { font-size: 1rem; }      /* 16px */
.text-sm { font-size: 0.875rem; } /* 14px */
```

---

### 余白とスペーシング

```css
/* セクション間の余白 */
section {
  padding: 5rem 0;  /* py-20 = 80px */
}

/* コンテナ */
.container {
  max-width: 1200px;  /* max-w-6xl */
  margin: 0 auto;
  padding: 0 1.5rem;  /* px-6 */
}

/* 見出しとコンテンツの間 */
h2 {
  margin-bottom: 2.5rem;  /* mb-10 */
}
```

**Tailwind クラス対応:**
- セクション: `py-20`
- コンテナ: `max-w-6xl mx-auto px-6`
- 見出し下: `mb-10`
- グリッド: `gap-6` or `gap-8`

---

### カード・セクションのスタイル

```css
/* シンプルなカード */
.card {
  background: #ffffff;
  border: 1px solid #e5e5e5;
  border-radius: 0.5rem;
  padding: 1.5rem;
  transition: all 0.2s ease;
}

.card:hover {
  border-color: #1a1a1a;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}
```

**Tailwind クラス:**
```html
<!-- カード -->
<div class="bg-white border border-gray-200 rounded-lg p-6
            transition-all hover:border-gray-900 hover:shadow-md">
```

---

### ボタンのスタイル

```css
/* プライマリボタン（黒背景） */
.btn-primary {
  display: inline-block;
  background: #1a1a1a;
  color: #ffffff;
  padding: 0.875rem 2rem;
  border-radius: 0.25rem;
  font-size: 0.875rem;
  font-weight: 500;
  border: none;
  cursor: pointer;
  transition: all 0.2s ease;
}

.btn-primary:hover {
  background: #333333;
}

/* セカンダリボタン（アウトライン） */
.btn-secondary {
  display: inline-block;
  background: transparent;
  color: #1a1a1a;
  padding: 0.875rem 2rem;
  border: 1px solid #1a1a1a;
  border-radius: 0.25rem;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.btn-secondary:hover {
  background: #1a1a1a;
  color: #ffffff;
}
```

**Tailwind クラス:**
```html
<!-- プライマリ -->
<a class="inline-block px-8 py-3.5 bg-gray-900 text-white text-sm font-medium
          rounded hover:bg-gray-800 transition-colors">

<!-- セカンダリ -->
<a class="inline-block px-8 py-3.5 border border-gray-900 text-gray-900 text-sm font-medium
          rounded hover:bg-gray-900 hover:text-white transition-colors">
```

---

### 画像の見せ方

```css
/* 画像コンテナ */
.image-container {
  position: relative;
  overflow: hidden;
  border-radius: 0.5rem;
}

/* ホバーで少し拡大 */
.image-container img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.image-container:hover img {
  transform: scale(1.02);
}
```

---

### アニメーション

```css
/* シンプルなフェードイン */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in {
  animation: fadeIn 0.5s ease-out forwards;
}

/* ホバーリフト（控えめ） */
.hover-lift {
  transition: transform 0.2s ease;
}
.hover-lift:hover {
  transform: translateY(-4px);
}

/* リンクの下線アニメーション */
.link-underline {
  position: relative;
}
.link-underline::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 0;
  height: 1px;
  background: #1a1a1a;
  transition: width 0.3s ease;
}
.link-underline:hover::after {
  width: 100%;
}
```

---

### ヘッダー/ナビゲーション

```css
header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 50;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(8px);
  border-bottom: 1px solid #e5e5e5;
  padding: 1rem 0;
  transition: all 0.3s ease;
}

nav a {
  color: #666666;
  text-decoration: none;
  font-size: 0.875rem;
  font-weight: 500;
  padding: 0.5rem 1rem;
  transition: color 0.2s ease;
}

nav a:hover {
  color: #1a1a1a;
}
```

---

## デザインチェックリスト

実装時に確認すること:

- [ ] ホワイトベースの配色になっている
- [ ] フォントはサンセリフ（Inter + Noto Sans JP）で統一
- [ ] シンプルでカジュアルな印象になっている
- [ ] 20代〜30代が好むモダンなデザインになっている
- [ ] ボタンにホバーエフェクトを追加した
- [ ] 画像にシンプルなトランジションを追加した
- [ ] ヘッダーを固定してブラーエフェクトを追加した
- [ ] カードにホバー時のボーダー強調を追加した

---

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
├── design/            # デザインシステム
│   ├── harayan-forest-redesign.jsx  # React参照
│   └── v0-prototype/                # v0プロトタイプ
└── logs/              # 実装ログ
    ├── progress.md    # 進捗チェックリスト
    └── history/       # 日別作業ログ
```

## ブランチ戦略（GitHub Flow）

### ブランチ構成
- `main` - 本番環境用、常にデプロイ可能な状態を維持
- `feature/*` - 新機能開発（例: `feature/add-google-map`）
- `fix/*` - バグ修正（例: `fix/header-responsive`）
- `chore/*` - 設定変更・リファクタ（例: `chore/update-ci`）

### 作業フロー
1. **ブランチ作成**: `git checkout -b feature/機能名`
2. **作業・コミット**: 細かく意味のある単位でコミット
3. **プッシュ**: `git push -u origin feature/機能名`
4. **PR作成**: GitHub上でPRを作成
5. **CIパス確認**: 全てのチェックが通ることを確認
6. **マージ**: Squash and merge を推奨
7. **ブランチ削除**: マージ後にリモート・ローカルのブランチを削除

### ルール
- mainへの直接プッシュ禁止（ブランチプロテクション設定済み）
- PRマージにはCI（test, system-test, lint）のパスが必須
- 1つのPRは1つの機能/修正に集中させる
- **PRのマージはユーザーが行う**（Claudeは PR作成・CI確認まで）

## CI/テストルール

- **コミット前**: `bundle exec rspec` でテストがパスすることを確認
- **プッシュ後**: GitHub Actions のCIが通ることを確認してから次のタスクに進む
- **CI失敗時**: 原因を調査・修正し、CIが通るまで他の作業に進まない

## セキュリティルール

- **環境設定・秘密情報は `.gitignore` に追加してコミットしない**
  - `.env` / `.env.*`
  - `config/credentials/*.key`
  - APIキー、パスワード等を含むファイル
- パブリックリポジトリのため、機密情報の取り扱いに注意

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
- **デザインチェックリストに沿ったクラス使用を徹底**

### カラー
- 背景: `bg-white`, `bg-gray-50`, `bg-gray-100`
- テキスト: `text-gray-900`, `text-gray-600`, `text-gray-500`
- ボーダー: `border-gray-200`, `border-gray-300`
- ボタン: `bg-gray-900 text-white`, `border-gray-900 text-gray-900`