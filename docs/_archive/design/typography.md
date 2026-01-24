# タイポグラフィ（Tailwind CSS）

## フォント

### 設定
`app/assets/tailwind/application.css` で定義
```css
--font-sans: 'Work Sans', 'Noto Sans JP', system-ui, sans-serif;
```

### Google Fonts読み込み
`app/views/layouts/application.html.erb` で読み込み

## フォントサイズ

| クラス | サイズ | 用途 |
|--------|--------|------|
| `text-xs` | 12px | 注釈 |
| `text-sm` | 14px | 補足、ナビ |
| `text-base` | 16px | 本文 |
| `text-lg` | 18px | リード文 |
| `text-xl` | 20px | 小見出し |
| `text-2xl` | 24px | 見出し |
| `text-3xl` | 30px | セクション見出し |
| `text-4xl` | 36px | ページタイトル |
| `text-5xl` | 48px | ヒーロータイトル |
| `text-6xl` | 60px | ヒーロー（大） |

## フォントウェイト

| クラス | ウェイト | 用途 |
|--------|----------|------|
| `font-light` | 300 | ヒーロー、大きな見出し |
| `font-normal` | 400 | 本文 |
| `font-medium` | 500 | ナビ、ラベル |
| `font-semibold` | 600 | 見出し |
| `font-bold` | 700 | 強調 |

## 行間

| クラス | 値 | 用途 |
|--------|-----|------|
| `leading-tight` | 1.25 | 見出し |
| `leading-normal` | 1.5 | 本文 |
| `leading-relaxed` | 1.625 | 長文 |
| `leading-loose` | 2 | ゆったり |

## 文字間隔

| クラス | 用途 |
|--------|------|
| `tracking-tight` | 詰め |
| `tracking-normal` | 通常 |
| `tracking-wide` | 広め（ロゴ） |
| `tracking-wider` | より広め（ナビ） |

## 使用例

### ページタイトル
```erb
<h1 class="text-4xl md:text-5xl font-light tracking-wide">
  タイトル
</h1>
```

### セクション見出し
```erb
<h2 class="text-3xl font-semibold">
  セクションタイトル
</h2>
```

### 本文
```erb
<p class="text-base leading-relaxed text-gray-600">
  本文テキスト
</p>
```

### ナビゲーション
```erb
<a class="text-sm font-medium tracking-wider uppercase">
  Menu
</a>
```

### 補足テキスト
```erb
<p class="text-sm text-gray-500">
  補足テキスト
</p>
```
