require "test_helper"

class EventTest < ActiveSupport::TestCase
  test 'Event.created_by?' do
    # created_by? => イベント作成者本人かどうか
    event = FactoryBot.create(:event)
    owner_user = MiniTest::Mock.new.expect(:id, event.owner_id)
    other_user = MiniTest::Mock.new.expect(:id, 2)

    assert_equal(true, event.created_by?(owner_user))
    assert_equal(false, event.created_by?(other_user))
    assert_equal(false, event.created_by?(nil))

    owner_user.verify
    other_user.verify
  end
end
