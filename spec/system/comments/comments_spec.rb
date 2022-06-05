require 'rails_helper'

RSpec.describe "Comments", type: :system do
  describe 'コメント投稿' do
    let!(:user) { create(:user) }
    let!(:post_1_by_others) { create(:post) }

    before do
      login_as user
    end
    it '投稿にコメントできること' do
      visit post_path(post_1_by_others)
      fill_in 'コメント', with: 'This is an example comment.'
      click_button '投稿'
      expect(page).to have_content 'This is an example comment.'
    end
  end

  describe 'コメント更新' do
    let!(:user) { create(:user) }
    let!(:post_1_by_others) { create(:post) }
    let!(:comment_by_user) { create(:comment, user: user, post: post_1_by_others) }
    let!(:comment_by_others) { create(:comment, post: post_1_by_others) }

    before do
      login_as user
    end

    it '自分のコメントには編集ボタンが表示される' do
      visit post_path(post_1_by_others)
      within "#comment-#{comment_by_user.id}" do
        expect(page).to have_css '.edit-button'
      end
    end

    it '他人のコメントには編集ボタンが表示されない' do
      visit post_path(post_1_by_others)
      within "#comment-#{comment_by_others.id}" do
        expect(page).not_to have_css '.edit-button'
      end
    end

    # it '自分のコメントを更新できる', js: true do
    #   visit post_path(post_1_by_others)
    #   within "#comment-#{comment_by_user.id}" do
    #     find(".edit-button").click
    #   end

    #   expect(page).to have_content 'コメント編集'
        # 下記の入力箇所の指定がうまくいかなかった
    #   # fill_in ('input-comment-body'), with: 'This is an update comment.'
    #   find('.modal-body').set('This is an update comment.')

    #   click_button '投稿'

    #   expect(current_path).to eq post_path(post_1_by_others)
    #   expect(page).to have_content 'This is an update comment.'
    # end
  end

  describe 'コメント削除' do
    let!(:user) { create(:user) }
    let!(:post_1_by_others) { create(:post) }
    let!(:comment_by_user) { create(:comment, user: user, post: post_1_by_others) }
    let!(:comment_by_others) { create(:comment, post: post_1_by_others) }

    before do
      login_as user
    end

    it '自分のコメントには削除ボタンが表示される' do
      visit post_path(post_1_by_others)
      within "#comment-#{comment_by_user.id}" do
        expect(page).to have_css '.delete-button'
      end
    end

    it '他人のコメントにはコメントには削除ボタンが表示されない' do
      visit post_path(post_1_by_others)
      within "#comment-#{comment_by_others.id}" do
        expect(page).not_to have_css '.delete-button'
      end
    end

    it '自分のコメントを削除できる' do
      visit post_path(post_1_by_others)
      within "#comment-#{comment_by_user.id}" do
        page.accept_confirm { find('.delete-button').click }
      end
      expect(page).not_to have_content comment_by_user.body
    end
  end
end
