# コンタクト

## URL
`/contact`

## 概要
お問い合わせページ（Googleフォーム埋め込み）

## セクション構成

### 1. ページヘッダー
- タイトル「Contact」
- サブタイトル

### 2. お問い合わせ案内
- 問い合わせ前の注意事項
- 回答までの目安時間

### 3. Googleフォーム埋め込み
```html
<iframe
  src="https://docs.google.com/forms/d/e/FORM_ID/viewform?embedded=true"
  width="100%"
  height="800"
  frameborder="0">
</iframe>
```

### 4. その他の連絡先（オプション）
- 電話番号
- メールアドレス
- 営業時間

## 実装メモ
- Googleフォームは別途作成が必要
- フォームIDは後で差し替え
- レスポンシブ対応（iframe幅調整）

## Googleフォームの項目例
- お名前
- メールアドレス
- 電話番号
- お問い合わせ種別（選択式）
- お問い合わせ内容（自由記述）
