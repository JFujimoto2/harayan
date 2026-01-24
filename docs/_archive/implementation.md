# 実装計画

## 画面構成
| ページ | URL | 説明 |
|-------|-----|------|
| トップ | `/` | 画像中心のヒーローセクション |
| About | `/about` | 会社概要 |
| 店舗情報 | `/shops` | 1店舗（複数店舗対応可） |
| 採用情報 | `/recruit` | 求人情報 |
| コンタクト | `/contact` | Googleフォーム埋め込み |

## 参考サイト
- https://www.andsupply.store/

## デザイン方針
- グリッドベースのレイアウト
- 画像中心のビジュアル
- カラー: 深緑系 `#3b5442`、グレー系
- フォント: Work Sans
- ホバーアニメーション

## ファイル構成

### コントローラー
```
app/controllers/pages_controller.rb
```

### ビュー
```
app/views/
├── layouts/
│   └── application.html.erb
├── shared/
│   ├── _header.html.erb
│   └── _footer.html.erb
└── pages/
    ├── home.html.erb
    ├── about.html.erb
    ├── shops.html.erb
    ├── recruit.html.erb
    └── contact.html.erb
```

### スタイル
```
app/assets/stylesheets/application.css
```

### 画像（ダミー）
```
app/assets/images/
├── hero.jpg
├── about.jpg
├── shop.jpg
└── recruit.jpg
```

## ルーティング
```ruby
root "pages#home"
get "about", to: "pages#about"
get "shops", to: "pages#shops"
get "recruit", to: "pages#recruit"
get "contact", to: "pages#contact"
```
