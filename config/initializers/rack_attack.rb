# frozen_string_literal: true

# テスト環境ではレートリミットを無効化
Rack::Attack.enabled = !Rails.env.test?

class Rack::Attack
  # キャッシュストアの設定（Rails.cacheを使用）
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # お問い合わせフォームのレートリミット
  # 同一IPから1分間に3回まで
  throttle("contact_form/ip", limit: 3, period: 1.minute) do |req|
    if req.path == "/contact" && req.post?
      req.ip
    end
  end

  # ブロックされた場合のレスポンス
  self.throttled_responder = lambda do |req|
    [
      429,
      { "Content-Type" => "text/html; charset=utf-8" },
      ["送信回数の制限を超えました。しばらく時間をおいてから再度お試しください。"]
    ]
  end
end
