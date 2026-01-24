# Instagram フィード埋め込み調査

> 各店舗ページにInstagramフィードを表示するための方法まとめ

---

## 概要

2020年以降、Instagramは公式APIの仕様変更により、フィードの埋め込みに認証が必要になった。
主な選択肢は以下の3つ。

---

## 方法比較

| 方法 | 難易度 | 初期コスト | 月額コスト | メリット | デメリット |
|------|--------|-----------|-----------|---------|-----------|
| サードパーティサービス | 簡単 | 無料〜 | 無料〜$20程度 | すぐ導入可能 | ロゴ表示、依存リスク |
| Instagram Graph API | 難 | 無料 | 無料 | 公式、自由度高 | 審査必要、開発工数大 |
| 手動更新 | 簡単 | 無料 | 無料 | 完全コントロール | 更新の手間 |

---

## 1. サードパーティサービス（推奨）

### SnapWidget
- **URL**: https://snapwidget.com/
- **無料プラン**: 1フィード、SnapWidgetロゴ表示
- **有料プラン**:
  - Pro: $6/月 - 3フィード、ロゴ非表示
  - Pro Plus: $12/月 - 10フィード
  - Business: $36/月 - 無制限

**メリット**: シンプル、軽量、設定簡単
**デメリット**: 無料はロゴ付き

---

### Elfsight
- **URL**: https://elfsight.com/instagram-feed-widget/
- **無料プラン**: 月200ビュー、Elfsightロゴ表示
- **有料プラン**:
  - Basic: $5/月 - 月5,000ビュー
  - Pro: $10/月 - 月50,000ビュー
  - Premium: $25/月 - 月無制限

**メリット**: カスタマイズ性高い、多機能
**デメリット**: 無料プランのビュー制限が厳しい

---

### Behold
- **URL**: https://behold.so/
- **無料プラン**: 1フィード、Beholdロゴ表示
- **有料プラン**:
  - Starter: $8/月 - 3フィード、ロゴ非表示
  - Pro: $19/月 - 10フィード
  - Business: $39/月 - 25フィード

**メリット**: モダンUI、開発者向けAPI提供
**デメリット**: 比較的新しいサービス

---

### Curator.io
- **URL**: https://curator.io/
- **無料プラン**: 1フィード、Curatorロゴ表示、1ソース
- **有料プラン**:
  - Professional: $25/月 - 3フィード
  - Business: $50/月 - 10フィード

**メリット**: 複数SNS統合可能（Instagram + Twitter等）
**デメリット**: 他と比べて高め

---

### LightWidget
- **URL**: https://lightwidget.com/
- **無料プラン**: なし
- **有料プラン**:
  - $10 買い切り（1フィード）

**メリット**: 買い切りで月額なし
**デメリット**: フィード追加ごとに購入必要

---

## 2. Instagram Graph API（公式）

### 必要なもの
- Instagramビジネスアカウント or クリエイターアカウント
- Facebookページ（Instagramと連携済み）
- Meta for Developersアカウント
- Facebookアプリ作成・審査

### 手順
1. Meta for Developers でアプリ作成
2. Instagram Graph API を追加
3. `instagram_basic` 権限でアプリ審査申請
4. 審査通過後、アクセストークン取得
5. APIでメディア取得 → キャッシュして表示

### API エンドポイント例
```
GET https://graph.instagram.com/me/media
  ?fields=id,caption,media_type,media_url,thumbnail_url,permalink,timestamp
  &access_token={access-token}
```

### コスト
- **API利用**: 無料
- **開発工数**: 数日〜1週間程度
- **審査期間**: 数日〜数週間

### メリット
- 公式なので安定
- カスタマイズ自由
- 外部サービス依存なし

### デメリット
- 審査が必要（落ちることもある）
- トークン更新の管理必要（60日で期限切れ）
- 開発・保守コスト

---

## 3. 手動更新

### 方法
- 定期的にInstagramから画像をダウンロード
- サイトの画像を差し替え
- または、個別投稿の埋め込みコードを使用

### 個別投稿の埋め込み方法
1. Instagramで投稿を開く
2. 「...」→「埋め込み」をクリック
3. 埋め込みコードをコピーしてサイトに貼り付け

```html
<blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/XXXXXX/">
</blockquote>
<script async src="//www.instagram.com/embed.js"></script>
```

### コスト
- **完全無料**
- **更新の手間**: 月1回程度の作業

---

## 推奨プラン

### 予算別おすすめ

| 予算 | おすすめ | 理由 |
|------|---------|------|
| 無料 | SnapWidget無料 or 手動 | ロゴ表示を許容できれば |
| 〜$10/月 | SnapWidget Pro ($6) | コスパ最強、3フィード使える |
| 〜$20/月 | Behold Starter ($8) × 複数 | モダンUI、API提供 |
| 開発リソースあり | Graph API | 長期的にはコスト最小 |

### Harayan の場合

**対象フィード**: 4アカウント
- @8108asakusa_shibuya
- @8108kamakura
- @a__kyoto
- @b__kyoto

**おすすめ**:
1. **SnapWidget Pro Plus ($12/月)** - 10フィードまで、ロゴ非表示
2. **LightWidget ($10 × 4 = $40 買い切り)** - 月額なし

---

## 実装例（SnapWidget）

```erb
<%# app/views/stores/hachijuhachi.html.erb %>

<%# Instagram セクション %>
<section class="py-20 bg-gray-50">
  <div class="max-w-4xl mx-auto px-6 text-center">
    <p class="text-sm text-gray-500 mb-2">Follow Us</p>
    <h2 class="text-3xl font-semibold text-gray-900 mb-4">Instagram</h2>
    <p class="text-gray-600 mb-8">
      <a href="https://www.instagram.com/8108asakusa_shibuya/" target="_blank" rel="noopener">
        @8108asakusa_shibuya
      </a>
    </p>

    <%# SnapWidget 埋め込み %>
    <iframe
      src="https://snapwidget.com/embed/XXXXXX"
      class="snapwidget-widget"
      allowtransparency="true"
      frameborder="0"
      scrolling="no"
      style="border:none; overflow:hidden; width:100%; height:400px;">
    </iframe>
  </div>
</section>
```

---

## 次のステップ

1. [ ] クライアントに予算・方針確認
2. [ ] サービス選定
3. [ ] アカウント作成・フィード設定
4. [ ] 埋め込みコード取得
5. [ ] 各店舗ページに実装

---

---

## Instagram Graph API 詳細ガイド

### 必要なもの一覧

#### クライアント側で用意

| 必要なもの | 詳細 | 状態 |
|-----------|------|------|
| **Instagramアカウント種別変更** | ビジネス or クリエイターアカウントに変更 | [ ] 未確認 |
| **Facebookページ** | 各Instagramアカウントと連携 | [ ] 未確認 |
| **Facebookページの管理者権限** | API認証に必要 | [ ] 未確認 |

#### 開発側で用意

| 必要なもの | 詳細 |
|-----------|------|
| **Meta for Developers アカウント** | https://developers.facebook.com/ |
| **Facebookアプリ作成** | Instagram Graph API を追加 |
| **アプリ審査申請** | `instagram_basic` 権限 |
| **長期アクセストークン管理** | 60日で期限切れ→自動更新の仕組み |

---

### 導入手順

```
[クライアント作業]
    │
    ├─ 1. Instagramをビジネスアカウントに変更
    │     └─ 設定 → アカウント → プロアカウントに切り替え
    │
    ├─ 2. Facebookページ作成（なければ）
    │
    └─ 3. InstagramとFacebookページを連携
          └─ Facebookページ設定 → Instagram → アカウントをリンク

[開発作業]
    │
    ├─ 4. Meta for Developers でアプリ作成
    │
    ├─ 5. Instagram Graph API を追加
    │
    ├─ 6. テスト用トークン取得（開発モード）
    │
    ├─ 7. アプリ審査申請
    │     └─ 審査期間: 数日〜数週間
    │
    ├─ 8. 審査通過後、本番トークン取得
    │
    └─ 9. Rails側で実装
          ├─ トークン自動更新ジョブ
          ├─ フィード取得・キャッシュ
          └─ 表示コンポーネント
```

---

### 開発工数見積もり

| 作業 | 工数 |
|------|------|
| Meta アプリ設定・審査申請 | 1-2時間 |
| 審査待ち | 数日〜2週間（コントロール外） |
| Rails実装（API連携） | 4-8時間 |
| トークン自動更新の仕組み | 2-4時間 |
| キャッシュ・エラーハンドリング | 2-4時間 |
| **合計** | **約1-2日 + 審査待ち** |

---

### クライアントへの確認事項

```
## Instagram Graph API 導入に必要な確認

### 1. アカウント種別
各Instagramアカウントは「ビジネスアカウント」または
「クリエイターアカウント」に変更されていますか？

- [ ] @8108asakusa_shibuya
- [ ] @8108kamakura
- [ ] @a__kyoto
- [ ] @b__kyoto

### 2. Facebookページ
各Instagramアカウントと連携するFacebookページはありますか？
（なければ作成が必要）

### 3. 権限
Facebookページの管理者権限を持つ方は誰ですか？
（API設定時にログインが必要になる場合があります）
```

---

### Meta審査に必要な情報

| 項目 | 内容 | 状態 |
|------|------|------|
| アプリの用途説明 | 「自社店舗サイトにInstagramフィードを表示するため」 | |
| プライバシーポリシーURL | サイトに設置必要 | [ ] 未作成 |
| 利用規約URL | サイトに設置必要（任意） | [ ] 未作成 |
| スクリーンショット | どのように使うかの画面キャプチャ | |

---

### Rails実装イメージ

#### サービスクラス
```ruby
# app/services/instagram_feed_service.rb
class InstagramFeedService
  GRAPH_API_URL = "https://graph.instagram.com"

  def initialize(access_token)
    @access_token = access_token
  end

  def fetch_media(limit: 12)
    response = HTTP.get(
      "#{GRAPH_API_URL}/me/media",
      params: {
        fields: "id,caption,media_type,media_url,thumbnail_url,permalink,timestamp",
        limit: limit,
        access_token: @access_token
      }
    )
    JSON.parse(response.body)["data"]
  end

  def refresh_token
    response = HTTP.get(
      "#{GRAPH_API_URL}/refresh_access_token",
      params: {
        grant_type: "ig_refresh_token",
        access_token: @access_token
      }
    )
    JSON.parse(response.body)["access_token"]
  end
end
```

#### キャッシュ付きフェッチ
```ruby
# app/models/instagram_account.rb
class InstagramAccount
  CACHE_DURATION = 1.hour

  def cached_feed
    Rails.cache.fetch("instagram_feed_#{username}", expires_in: CACHE_DURATION) do
      InstagramFeedService.new(access_token).fetch_media
    end
  end
end
```

#### トークン自動更新ジョブ
```ruby
# app/jobs/refresh_instagram_tokens_job.rb
class RefreshInstagramTokensJob < ApplicationJob
  queue_as :default

  # 50日ごとに実行（60日で期限切れのため余裕を持って）
  def perform
    InstagramAccount.find_each do |account|
      new_token = InstagramFeedService.new(account.access_token).refresh_token
      account.update!(access_token: new_token)
    end
  end
end
```

---

### トークン管理の注意点

| 項目 | 内容 |
|------|------|
| 短期トークン | 1時間で期限切れ |
| 長期トークン | 60日で期限切れ |
| 更新方法 | 期限切れ前に refresh_access_token エンドポイント呼び出し |
| 保存場所 | 環境変数 or 暗号化してDB保存 |

**重要**: トークンは機密情報。GitHubにコミットしないこと。

---

## 参考リンク

- [Instagram Graph API ドキュメント](https://developers.facebook.com/docs/instagram-api/)
- [Instagram Basic Display API](https://developers.facebook.com/docs/instagram-basic-display-api/)
- [アクセストークンの取得](https://developers.facebook.com/docs/instagram-basic-display-api/guides/getting-access-tokens-and-permissions/)
- [長期トークンの更新](https://developers.facebook.com/docs/instagram-basic-display-api/guides/long-lived-access-tokens/)
- [SnapWidget](https://snapwidget.com/)
- [Elfsight Instagram Widget](https://elfsight.com/instagram-feed-widget/)
- [Behold](https://behold.so/)
- [LightWidget](https://lightwidget.com/)
