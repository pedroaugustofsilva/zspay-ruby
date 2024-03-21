# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "simplecov"
SimpleCov.start do
  add_filter "/test/"
end

require "zspay"

require "webmock"
require "webmock/minitest"

require "minitest/autorun"
