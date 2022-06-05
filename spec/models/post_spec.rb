require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーション' do
    it '本文は必須であること' do
      post = build(:post, body: nil)
      post.valid?
      expect(post.errors[:body]).to include('を入力してください')
    end

    it '本文は1000文字以内であること' do
      post = build(:post, body: 'a' * 1001)
      post.valid?
      expect(post.errors[:body]).to include('は1000文字以内で入力してください')
    end
  end

  describe 'スコープ' do

  end
end
