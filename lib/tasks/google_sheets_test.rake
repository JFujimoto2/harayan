# frozen_string_literal: true

namespace :google_sheets do
  desc "Test Google Sheets API connection and write a test row"
  task test: :environment do
    require "google/apis/sheets_v4"
    require "googleauth"

    spreadsheet_id = ENV["GOOGLE_SHEETS_SPREADSHEET_ID"]
    credentials_path = ENV["GOOGLE_SHEETS_CREDENTIALS"]

    if spreadsheet_id.blank? || credentials_path.blank?
      puts "Error: GOOGLE_SHEETS_SPREADSHEET_ID or GOOGLE_SHEETS_CREDENTIALS is not set"
      exit 1
    end

    # Initialize the Sheets API
    service = Google::Apis::SheetsV4::SheetsService.new
    service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(credentials_path),
      scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS
    )

    # Test data
    test_row = [
      Time.current.strftime("%Y-%m-%d %H:%M:%S"),
      "テスト太郎",
      "test@example.com",
      "03-1234-5678",
      "一般的なお問い合わせ",
      "これはGoogle Sheets APIのテストです。"
    ]

    # Append the row
    range = "A:F"
    value_range = Google::Apis::SheetsV4::ValueRange.new(values: [ test_row ])

    begin
      service.append_spreadsheet_value(
        spreadsheet_id,
        range,
        value_range,
        value_input_option: "USER_ENTERED"
      )
      puts "✅ Google Sheets: Test row added successfully!"
      puts "   Check your spreadsheet: https://docs.google.com/spreadsheets/d/#{spreadsheet_id}"
    rescue Google::Apis::Error => e
      puts "❌ Google Sheets API Error: #{e.message}"
      exit 1
    end
  end
end
