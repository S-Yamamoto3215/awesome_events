require "test_helper"

class EventTest < ActiveSupport::TestCase
  test 'Event.created_by?' do
    # created_by? => イベント作成者本人かどうか
    # userを2種類用意
    owner_user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)

    # owner_userでevent作成
    target_event = FactoryBot.create(:event, owner: owner_user)

    # created_by?の引数が作成者と同じ
    assert_equal(true, target_event.created_by?(owner_user))
    # created_by?の引数が作成者と異なる
    assert_equal(false, target_event.created_by?(other_user))
    # created_by?の引数がnil
    assert_equal(false, target_event.created_by?(nil))
  end
end
