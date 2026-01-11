# frozen_string_literal: true

class ContactsController < ApplicationController
  def create
    # バリデーション
    errors = validate_contact_params
    if errors.any?
      flash.now[:alert] = errors.join("、")
      @contact = contact_params
      render "pages/contact", status: :unprocessable_entity
      return
    end

    # Google Sheetsに保存
    save_to_google_sheets

    # Slack通知
    send_slack_notification

    redirect_to contact_path, notice: "お問い合わせありがとうございます。内容を確認次第、ご連絡いたします。"
  rescue StandardError => e
    Rails.logger.error "Contact form error: #{e.message}"
    redirect_to contact_path, alert: "送信中にエラーが発生しました。お手数ですがお電話でお問い合わせください。"
  end

  private

  def contact_params
    @contact_params ||= {
      name: params[:name],
      email: params[:email],
      phone: params[:phone],
      subject: params[:subject],
      message: params[:message]
    }
  end

  def validate_contact_params
    errors = []

    # 必須項目チェック
    errors << "お名前を入力してください" if contact_params[:name].blank?
    errors << "メールアドレスを入力してください" if contact_params[:email].blank?
    errors << "お問い合わせ種別を選択してください" if contact_params[:subject].blank?
    errors << "お問い合わせ内容を入力してください" if contact_params[:message].blank?

    # メールアドレス形式チェック
    if contact_params[:email].present?
      email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      errors << "メールアドレスの形式が正しくありません" unless contact_params[:email].match?(email_regex)
    end

    # 電話番号形式チェック（入力がある場合のみ）
    if contact_params[:phone].present?
      # 日本の電話番号: 数字とハイフンのみ、10-13桁
      phone_normalized = contact_params[:phone].gsub(/[-\s]/, "")
      unless phone_normalized.match?(/\A\d{10,11}\z/)
        errors << "電話番号の形式が正しくありません（例: 03-1234-5678、09012345678）"
      end
    end

    errors
  end

  def subject_label
    subjects = {
      "general" => "一般的なお問い合わせ",
      "service" => "サービスについて",
      "recruit" => "採用について",
      "other" => "その他"
    }
    subjects[contact_params[:subject]] || contact_params[:subject]
  end

  def save_to_google_sheets
    require "google/apis/sheets_v4"
    require "googleauth"

    spreadsheet_id = ENV["GOOGLE_SHEETS_SPREADSHEET_ID"]
    credentials_path = ENV["GOOGLE_SHEETS_CREDENTIALS"]

    return if spreadsheet_id.blank? || credentials_path.blank?

    service = Google::Apis::SheetsV4::SheetsService.new
    service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(credentials_path),
      scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS
    )

    row = [
      Time.current.strftime("%Y-%m-%d %H:%M:%S"),
      contact_params[:name],
      contact_params[:email],
      contact_params[:phone],
      subject_label,
      contact_params[:message]
    ]

    value_range = Google::Apis::SheetsV4::ValueRange.new(values: [row])

    service.append_spreadsheet_value(
      spreadsheet_id,
      "A:F",
      value_range,
      value_input_option: "USER_ENTERED"
    )
  end

  def send_slack_notification
    require "net/http"
    require "json"

    webhook_url = ENV["SLACK_WEBHOOK_URL"]
    return if webhook_url.blank?

    message = {
      text: "📩 *新しいお問い合わせ*\n\n" \
            "お名前: #{contact_params[:name]}\n" \
            "メール: #{contact_params[:email]}\n" \
            "電話: #{contact_params[:phone].presence || '未入力'}\n" \
            "種別: #{subject_label}\n" \
            "内容:\n#{contact_params[:message]}"
    }

    uri = URI(webhook_url)
    Net::HTTP.post(uri, message.to_json, "Content-Type" => "application/json")
  end
end
