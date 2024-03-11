# frozen_string_literal: true

require "test_helper"

class TestClient < Minitest::Test
  def setup
    @clients_path = "/clientes"
  end

  def test_create
    client_data = { name: "John Doe", email: "johndoe@example.com" }
    mock = Minitest::Mock.new
    mock.expect :call, [], [@clients_path, client_data]

    Zspay::Client.stub :post, mock do
      Zspay::Client.create(client_data)
    end

    mock.verify
  end

  def test_create_card
    client_id = "123"
    card_data = { number: "4111111111111111", expiry_month: "12", expiry_year: "2023", cvv: "123" }
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@clients_path}/#{client_id}/cartoes", card_data]

    Zspay::Client.stub :post, mock do
      Zspay::Client.create_card(client_id, card_data)
    end

    mock.verify
  end
end
