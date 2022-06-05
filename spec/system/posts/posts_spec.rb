require 'rails_helper'

RSpec.describe "Posts", type: :system do
  # describe 'ポスト一覧' do
  #   let!(:user) { create(:user) }
  #   let!(:post_1_by_others) { create(:post) }
  #   let!(:post_2_by_others) { create(:post) }
  #   let!(:post_by_user) { create(:post, user: user) }

  #   context 'ログインしている場合' do
  #     before do
  #       login_as user
  #     end
  #   end
  # end

  describe 'ポスト投稿' do
    it '投稿できること' do
      login
      visit new_post_path
      within '#posts_form' do
        fill_in '本文', with: 'This is sample post.'
        click_button '登録する'
      end

      expect(current_path).to eq posts_path
      expect(page).to have_content '投稿しました'
      expect(page).to have_content 'This is sample post.'
    end
  end

  describe 'ポスト更新' do
    let!(:user) { create(:user) }
    let!(:post_1_by_others) { create(:post) }
    let!(:post_2_by_others) { create(:post) }
    let!(:post_by_user) { create(:post, user: user) }
    before do
      login_as user
    end

    it '自分の投稿に編集ボタンが表示される' do
      visit posts_path
      within "#post-#{post_by_user.id}" do
        expect(page).to have_css '.edit-button'
      end
    end

    it '他人の投稿には編集ボタンが表示されないこと' do
      visit posts_path
      within "#post-#{post_1_by_others.id}" do
        expect(page).not_to have_css '.edit-button'
      end
    end

    it '投稿を更新できること' do
      visit edit_post_path(post_by_user)
      within '#posts_form' do
        fill_in '本文', with: 'This is an example update post.'
        click_button '更新する'
      end
      expect(current_path).to eq posts_path
      expect(page).to have_content('投稿を更新しました')
      expect(page).to have_content('This is an example update post.')
    end
  end

  describe 'ポスト削除' do
    let!(:user) { create(:user) }
    let!(:post_1_by_others) { create(:post) }
    let!(:post_by_user) { create(:post, user: user) }
    before do
      login_as user
    end

    it '自分の投稿に削除ボタンが表示される' do
      visit posts_path
      within "#post-#{post_by_user.id}" do
        expect(page).to have_css '.delete-button'
      end
    end

    it '他人の投稿には削除ボタンが表示されないこと' do
      visit posts_path
      within "#post-#{post_1_by_others.id}" do
        expect(page).not_to have_css '.delete-button'
      end
    end

    it '投稿が削除できること' do
      visit posts_path
      within "#post-#{post_by_user.id}" do
        page.accept_confirm { find('.delete-button').click }
      end
      expect(current_path).to eq posts_path
      expect(page).to have_content '投稿を削除しました'
      expect(page).not_to have_content post_by_user.body
    end
  end

  describe 'ポスト詳細' do
    let!(:user) { create(:user) }
    let!(:post_by_user) { create(:post, user: user) }
    before do
      login_as user
    end

    it '投稿の詳細画面が閲覧できること' do
      visit post_path(post_by_user)
      expect(current_path).to eq post_path(post_by_user)
      # expect(page).to have_content post_by_user.body
    end
  end


end
