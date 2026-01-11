# frozen_string_literal: true

namespace :slack do
  desc "Test Slack webhook notification"
  task test: :environment do
    require "net/http"
    require "json"

    webhook_url = ENV["SLACK_WEBHOOK_URL"]

    if webhook_url.blank?
      puts "Error: SLACK_WEBHOOK_URL is not set"
      exit 1
    end

    message = {
      text: "🧪 *テスト通知*\n\nHarayanお問い合わせフォームからのテスト送信です。\n\n" \
            "お名前: テスト太郎\n" \
            "メール: test@example.com\n" \
            "電話: 03-1234-5678\n" \
            "種別: 一般的なお問い合わせ\n" \
            "内容:\nこれはテストメッセージです。"
    }

    uri = URI(webhook_url)
    response = Net::HTTP.post(
      uri,
      message.to_json,
      "Content-Type" => "application/json"
    )

    if response.is_a?(Net::HTTPSuccess)
      puts "✅ Slack notification sent successfully!"
    else
      puts "❌ Failed to send notification"
      puts "Status: #{response.code}"
      puts "Body: #{response.body}"
    end
  end
end
