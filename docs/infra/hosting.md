# ホスティング選定

## 結論: Cloudflare Pages を採用

静的サイトのホスティングには **Cloudflare Pages** を使用する。

## 選定理由

### 1. 無料で商用利用OK
- GitHub Pagesは個人・OSS向けの位置づけだが、Cloudflare Pagesは商用利用が明確にOK

### 2. 管理が一元化できる
- ドメイン購入、DNS設定、デプロイがすべてCloudflare内で完結
- 更新頻度が低いサイトでも「どこで何を設定したか」迷わない

### 3. 高性能
- 世界中にCDNがあり高速
- 帯域幅無制限（GitHub Pagesは月100GB制限）
- SSL証明書は自動発行

## GitHub Pages との比較

| 項目 | GitHub Pages | Cloudflare Pages |
|------|--------------|------------------|
| 料金 | 無料 | 無料 |
| 独自ドメイン | ○ | ○ |
| SSL | ○ 自動 | ○ 自動 |
| 帯域幅制限 | 月100GB | 無制限 |
| 商用利用 | △ 推奨されない | ○ OK |
| CDN | 基本的 | 世界中に高速CDN |
| 管理 | DNS設定は外部 | 一元管理可能 |

## 構成

```
ドメイン取得 → Cloudflare Registrar（原価提供、年間約1,500円〜）
ホスティング → Cloudflare Pages（無料）
ソース管理  → GitHub
```

## デプロイフロー

```
GitHubにHTMLをプッシュ → Cloudflare Pagesが自動で公開
```

更新時もGitHubにプッシュするだけで自動反映される。
