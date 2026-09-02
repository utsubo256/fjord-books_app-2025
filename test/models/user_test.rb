# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should return name when name exists' do
    user = users(:alice)
    assert_equal 'Alice', user.name_or_email
  end

  test 'should return email when name does not exist' do
    user = users(:alice)
    user.name = nil
    assert_equal 'alice@example.com', user.name_or_email
  end
end
