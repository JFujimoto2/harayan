# カラーパレット

## カスタムカラー（Tailwind設定）

`app/assets/tailwind/application.css` で定義

### Primary（深緑系）
| クラス | 値 | 用途 |
|--------|-----|------|
| `primary-50` | #f0f5f1 | 背景（薄） |
| `primary-100` | #dce8de | ホバー背景 |
| `primary-200` | #b8d1bd | ボーダー |
| `primary-500` | #3b5442 | メインカラー |
| `primary-600` | #2d4033 | ホバー |
| `primary-700` | #243329 | アクティブ |

### Accent（ブラウン系）
| クラス | 値 | 用途 |
|--------|-----|------|
| `accent-50` | #f9f6f4 | 背景（薄） |
| `accent-500` | #745d4a | アクセント |
| `accent-600` | #5c4a3b | ホバー |

## Tailwindデフォルトカラー
よく使うものをピックアップ

### グレー系
```html
text-gray-900   <!-- 本文テキスト -->
text-gray-600   <!-- サブテキスト -->
text-gray-400   <!-- 薄いテキスト -->
bg-gray-50      <!-- 薄い背景 -->
bg-gray-100     <!-- セクション背景 -->
bg-gray-900     <!-- フッター背景 -->
border-gray-100 <!-- 薄いボーダー -->
border-gray-200 <!-- ボーダー -->
```

### 白黒
```html
text-white      <!-- 白テキスト -->
bg-white        <!-- 白背景 -->
bg-black        <!-- 黒背景 -->
```

## 使用例

```erb
<%# プライマリボタン %>
<button class="bg-primary-500 hover:bg-primary-600 text-white">
  送信
</button>

<%# アウトラインボタン %>
<button class="border border-primary-500 text-primary-500 hover:bg-primary-500 hover:text-white">
  詳しく見る
</button>

<%# カード %>
<div class="bg-white border border-gray-200 hover:border-primary-300">
  ...
</div>
```
