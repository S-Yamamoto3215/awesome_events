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

  test 'validate test start_at_before_end_at OK' do
    start_at = rand(1..30).days.from_now
    end_at = start_at + rand(1..30).hours
    event = FactoryBot.build(:event, start_at: start_at, end_at: end_at)
    event.valid?
    assert_empty(event.errors[:start_at])
  end

  test 'validate test start_at_before_end_at NG' do
    start_at = rand(1..30).days.from_now
    end_at = start_at - rand(1..30).hours
    event = FactoryBot.build(:event, start_at: start_at, end_at: end_at)
    event.valid?
    assert_not_empty(event.errors[:start_at])
  end
end
