require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  test '自分の作成したイベントは削除可能' do
    event_owner = FactoryBot.create(:user)
    event = FactoryBot.create(:event, owner: event_owner)
    sign_in_as(event_owner)
    assert_difference('Event.count', -1) do
      delete event_url(event)
    end
  end

  test '自分以外が作成したイベントは削除不可能' do
    event_owner = FactoryBot.create(:user)
    event = FactoryBot.create(:event, owner: event_owner)
    sign_in_user = FactoryBot.create(:user)
    sign_in_as(sign_in_user)
    assert_difference('Event.count', 0) do
      delete event_url(event)
    end
  end
end
