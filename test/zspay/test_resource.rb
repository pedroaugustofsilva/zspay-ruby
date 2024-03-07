# frozen_string_literal: true

require "test_helper"

class TestResource < Minitest::Test
  def setup
    @base_uri = "https://api.zsystems.com.br"
    @resource_path = "/estabelecimentos"
    @token = "test_token"

    Zspay.configure do |config|
      config.token = @token
    end
  end

  def stub_zspay_request(method, path, status: 200, response_body: {}, request_body: {})
    stub_request(method, "#{@base_uri}#{path}")
      .with(
        body: request_body,
        headers: { Authorization: "Bearer #{@token}" }
      )
      .to_return(
        status: status,
        body: response_body.to_json
      )
  end

  def test_successful_get
    expected_response = { "id" => 1, "name" => "Test Establishment" }
    stub_zspay_request(:get, "#{@resource_path}/1", response_body: expected_response)

    response = Zspay::Resource.get("#{@resource_path}/1")

    assert_equal 1, response.id
    assert_equal "Test Establishment", response.name
  end

  def test_successful_post_without_payload
    expected_response = { "name" => "Test Establishment" }
    stub_zspay_request(:post, @resource_path, response_body: expected_response, status: 201)

    response = Zspay::Resource.post(@resource_path)

    assert_equal "Test Establishment", response.name
  end

  def test_successful_post_with_payload
    body_and_response = { "name" => "Establishment Name" }
    stub_zspay_request(:post, "#{@resource_path}/1", response_body: body_and_response, request_body: body_and_response)

    response = Zspay::Resource.post("#{@resource_path}/1", body_and_response)

    assert_equal "Establishment Name", response.name
  end

  def test_successful_patch
    body_and_response = { "name" => "New Establishment Name" }
    stub_zspay_request(:patch, "#{@resource_path}/1", response_body: body_and_response, request_body: body_and_response)

    response = Zspay::Resource.patch("#{@resource_path}/1", body_and_response)

    assert_equal "New Establishment Name", response.name
  end

  def test_successful_delete
    stub_zspay_request(:delete, "#{@resource_path}/1", response_body: {})

    response = Zspay::Resource.delete("#{@resource_path}/1")

    assert_empty(response.table)
  end

  def test_fail_request_should_return_success_false
    stub_zspay_request(:post, @resource_path, status: 422)

    response = Zspay::Resource.post(@resource_path)

    refute response.success
  end
end
