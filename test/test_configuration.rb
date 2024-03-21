# frozen_string_literal: true

require "test_helper"

class TestConfiguration < Minitest::Test
  def setup
    Zspay.configure do |config|
      config.token = "my_token"
    end
  end

  def test_that_it_assign_token
    assert_equal "my_token", Zspay.configuration.token
  end
end
