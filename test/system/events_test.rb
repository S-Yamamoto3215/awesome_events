# frozen_string_literal: true
require 'application_system_test_case'

class EventsTest < ApplicationSystemTestCase
  test '/events/:id ページを表示' do
    event = FactoryBot.create(:event)
    visit event_url(event)
    assert_selector 'h1', text: event.name
  end

  test '/events/new ページを表示' do
    sign_in_as(FactoryBot.create(:user))

    visit new_event_url
    assert_selector 'h1', text: 'イベント作成'
  end

  test '/events/new ページでフォームへ記入して登録' do
    sign_in_as(FactoryBot.create(:user))

    visit new_event_url
    assert_selector 'h1', text: 'イベント作成'

    fill_in '名前', with: 'Miyazaki.rb'
    fill_in '場所', with: '宮崎'

    start_at = Time.current
    end_at = start_at + 3.hour
    fill_in '開始時間', with: start_at
    fill_in '終了時間', with: end_at

    fill_in '内容', with: '宮崎のRubyエンジニアコミュニティ'

    click_on '登録する'
    assert_selector 'div.alert', text: '作成しました'
  end

  test '/events/:id ページを表示して削除ボタンを押す' do
    sign_in_as(FactoryBot.create(:user))
    event = FactoryBot.create(:event, owner: current_user)

    visit event_url(event)

    assert_difference('Event.count', -1) do
      accept_confirm do
        click_on 'イベントを削除する'
      end
      assert_selector 'div.alert', text: '削除しました'
    end
  end
end
