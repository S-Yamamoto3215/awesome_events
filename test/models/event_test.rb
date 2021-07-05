require "test_helper"

class EventTest < ActiveSupport::TestCase
  test 'Event.created_by?' do
    # created_by? => イベント作成者本人かどうか
    # event作成
    event = FactoryBot.create(:event)

    user = User.new
    user.stub(:id, event.owner_id) do
      assert_equal(true, event.created_by?(user))
    end
    #
    # # created_by?の引数が作成者と同じ
    #
    # # created_by?の引数が作成者と異なる
    # assert_equal(false, target_event.created_by?(other_user))
    # # created_by?の引数がnil
    # assert_equal(false, target_event.created_by?(nil))
  end
end
