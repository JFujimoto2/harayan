# レイアウト（Tailwind CSS）

## コンテナ

### 標準コンテナ
```erb
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
  ...
</div>
```

### 狭いコンテナ（本文用）
```erb
<div class="max-w-3xl mx-auto px-4 sm:px-6">
  ...
</div>
```

### フルワイド
```erb
<div class="w-full">
  ...
</div>
```

## スペーシング

### セクション間
```erb
<section class="py-20">  <!-- 上下 80px -->
<section class="py-16">  <!-- 上下 64px -->
<section class="py-12">  <!-- 上下 48px -->
```

### 要素間
```erb
<div class="mb-4">   <!-- 16px -->
<div class="mb-6">   <!-- 24px -->
<div class="mb-8">   <!-- 32px -->
<div class="mb-12">  <!-- 48px -->
```

## ブレイクポイント

| プレフィックス | 最小幅 | 用途 |
|----------------|--------|------|
| (なし) | 0px | モバイル |
| `sm:` | 640px | 大きめスマホ |
| `md:` | 768px | タブレット |
| `lg:` | 1024px | デスクトップ |
| `xl:` | 1280px | 大画面 |
| `2xl:` | 1536px | 超大画面 |

### 使用例
```erb
<div class="text-base md:text-lg lg:text-xl">
  <!-- モバイル: 16px, タブレット: 18px, デスクトップ: 20px -->
</div>

<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
  <!-- モバイル: 1列, タブレット: 2列, デスクトップ: 3列 -->
</div>
```

## ページ構造

```erb
<%# ヘッダー固定、メイン、フッター %>
<body class="font-sans text-gray-900 antialiased">
  <%= render "shared/header" %>    <%# 固定ヘッダー（h-20） %>
  <main>
    <%= yield %>
  </main>
  <%= render "shared/footer" %>
</body>
```

## セクションパターン

### ヒーローセクション
```erb
<section class="relative h-screen min-h-[600px]">
  ...
</section>
```

### 通常セクション
```erb
<section class="py-20">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="text-center mb-12">
      <h2 class="text-3xl font-semibold mb-4">タイトル</h2>
      <p class="text-gray-600">サブタイトル</p>
    </div>
    <!-- コンテンツ -->
  </div>
</section>
```

### 交互背景セクション
```erb
<%# 白背景 %>
<section class="py-20 bg-white">...</section>

<%# グレー背景 %>
<section class="py-20 bg-gray-50">...</section>

<%# ダーク背景 %>
<section class="py-20 bg-gray-900 text-white">...</section>
```

## Flexbox

### 中央揃え
```erb
<div class="flex items-center justify-center">
```

### 両端揃え
```erb
<div class="flex items-center justify-between">
```

### 縦並び
```erb
<div class="flex flex-col gap-4">
```

## Grid

### 2カラム（等幅）
```erb
<div class="grid grid-cols-1 md:grid-cols-2 gap-8">
```

### 3カラム
```erb
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
```

### サイドバーレイアウト
```erb
<div class="grid grid-cols-1 lg:grid-cols-[1fr_300px] gap-8">
  <main>...</main>
  <aside>...</aside>
</div>
```
