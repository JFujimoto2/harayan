# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Contacts", type: :request do
  let(:valid_params) do
    {
      name: "テスト太郎",
      email: "test@example.com",
      phone: "03-1234-5678",
      subject: "general",
      message: "テストメッセージです。"
    }
  end

  before do
    # 外部APIをモック
    allow_any_instance_of(ContactsController).to receive(:save_to_google_sheets)
    allow_any_instance_of(ContactsController).to receive(:send_slack_notification)
  end

  describe "POST /contact" do
    context "with valid parameters" do
      it "redirects to contact page with success message" do
        post contact_path, params: valid_params

        expect(response).to redirect_to(contact_path)
        follow_redirect!
        expect(response.body).to include("お問い合わせありがとうございます")
      end

      it "accepts phone number without hyphens" do
        post contact_path, params: valid_params.merge(phone: "09012345678")

        expect(response).to redirect_to(contact_path)
      end

      it "accepts empty phone number" do
        post contact_path, params: valid_params.merge(phone: "")

        expect(response).to redirect_to(contact_path)
      end
    end

    context "with invalid email" do
      it "returns error for invalid email format" do
        post contact_path, params: valid_params.merge(email: "invalid-email")

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("メールアドレスの形式が正しくありません")
      end

      it "returns error for empty email" do
        post contact_path, params: valid_params.merge(email: "")

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("メールアドレスを入力してください")
      end
    end

    context "with invalid phone number" do
      it "returns error for phone with letters" do
        post contact_path, params: valid_params.merge(phone: "abc-1234-5678")

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("電話番号の形式が正しくありません")
      end

      it "returns error for phone too short" do
        post contact_path, params: valid_params.merge(phone: "123456")

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("電話番号の形式が正しくありません")
      end

      it "returns error for phone too long" do
        post contact_path, params: valid_params.merge(phone: "123456789012345")

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("電話番号の形式が正しくありません")
      end
    end

    context "with missing required fields" do
      it "returns error for empty name" do
        post contact_path, params: valid_params.merge(name: "")

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("お名前を入力してください")
      end

      it "returns error for empty subject" do
        post contact_path, params: valid_params.merge(subject: "")

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("お問い合わせ種別を選択してください")
      end

      it "returns error for empty message" do
        post contact_path, params: valid_params.merge(message: "")

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("お問い合わせ内容を入力してください")
      end
    end

    context "when validation fails" do
      it "preserves form values" do
        post contact_path, params: valid_params.merge(email: "invalid")

        expect(response.body).to include("テスト太郎")
        expect(response.body).to include("03-1234-5678")
        expect(response.body).to include("テストメッセージです。")
      end
    end
  end
end
