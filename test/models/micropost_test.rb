require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup

    @user = users(:michael)
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user_id)
    
  end

  test "should be valid" do
      assert @micropost.valid?
  end

  test "user id should be present" do
      @micropost.user_id = nil
      assert_not  @micropost.valid?
  end
end
