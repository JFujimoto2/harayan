# UIコンポーネント（Tailwind CSS）

## ボタン

### プライマリボタン
```erb
<%= link_to "ボタン", path,
    class: "inline-block px-6 py-3 bg-primary-500 text-white font-medium
           hover:bg-primary-600 transition-colors" %>
```

### アウトラインボタン
```erb
<%= link_to "ボタン", path,
    class: "inline-block px-6 py-3 border border-primary-500 text-primary-500
           hover:bg-primary-500 hover:text-white transition-colors" %>
```

### ゴーストボタン（白背景用）
```erb
<%= link_to "ボタン", path,
    class: "inline-block px-6 py-3 text-gray-600
           hover:text-primary-600 transition-colors" %>
```

## カード

### 基本カード
```erb
<div class="bg-white border border-gray-200 overflow-hidden
            hover:border-primary-300 hover:-translate-y-1
            transition-all duration-300">
  <%= image_tag "image.jpg", class: "w-full aspect-video object-cover" %>
  <div class="p-6">
    <h3 class="text-xl font-semibold mb-2">タイトル</h3>
    <p class="text-gray-600">説明文</p>
  </div>
</div>
```

### 画像オーバーレイカード
```erb
<div class="relative group overflow-hidden">
  <%= image_tag "image.jpg", class: "w-full aspect-video object-cover
                                     group-hover:scale-105 transition-transform duration-500" %>
  <div class="absolute inset-0 bg-black/40 flex items-center justify-center">
    <h3 class="text-white text-2xl font-semibold">タイトル</h3>
  </div>
</div>
```

## ナビゲーション

### ナビリンク
```erb
<%= link_to "About", about_path,
    class: "text-sm font-medium tracking-wider uppercase
           text-gray-600 hover:text-primary-600 transition-colors" %>
```

### アクティブ状態
```erb
<%= link_to "About", about_path,
    class: "text-sm font-medium tracking-wider uppercase
           #{current_page?(about_path) ? 'text-primary-600' : 'text-gray-600 hover:text-primary-600'}
           transition-colors" %>
```

## セクション

### セクションヘッダー
```erb
<div class="text-center mb-12">
  <h2 class="text-3xl font-semibold mb-4">セクションタイトル</h2>
  <p class="text-gray-600 max-w-2xl mx-auto">
    セクションの説明文をここに入れます
  </p>
</div>
```

### セクション（交互背景）
```erb
<%# 白背景 %>
<section class="py-20">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    ...
  </div>
</section>

<%# グレー背景 %>
<section class="py-20 bg-gray-50">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    ...
  </div>
</section>
```

## ヒーロー

### フルスクリーンヒーロー
```erb
<section class="relative h-screen min-h-[600px] flex items-center justify-center">
  <%# 背景画像 %>
  <div class="absolute inset-0">
    <%= image_tag "hero.jpg", class: "w-full h-full object-cover" %>
    <div class="absolute inset-0 bg-black/40"></div>
  </div>

  <%# コンテンツ %>
  <div class="relative z-10 text-center text-white px-4">
    <h1 class="text-5xl md:text-6xl font-light tracking-wider mb-6">
      タイトル
    </h1>
    <p class="text-lg md:text-xl font-light mb-8 max-w-2xl mx-auto">
      サブタイトル
    </p>
    <%= link_to "詳しく見る", about_path,
        class: "inline-block px-8 py-4 border border-white text-white
               hover:bg-white hover:text-gray-900 transition-colors" %>
  </div>
</section>
```

## テーブル（会社概要用）

```erb
<table class="w-full">
  <tbody>
    <tr class="border-b border-gray-200">
      <th class="py-4 pr-4 text-left text-gray-500 font-medium w-1/3">会社名</th>
      <td class="py-4">株式会社Harayan</td>
    </tr>
    <tr class="border-b border-gray-200">
      <th class="py-4 pr-4 text-left text-gray-500 font-medium">設立</th>
      <td class="py-4">2024年1月</td>
    </tr>
  </tbody>
</table>
```

## グリッド

### 2カラム
```erb
<div class="grid grid-cols-1 md:grid-cols-2 gap-8">
  ...
</div>
```

### 3カラム
```erb
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
  ...
</div>
```

### 4カラム
```erb
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
  ...
</div>
```
