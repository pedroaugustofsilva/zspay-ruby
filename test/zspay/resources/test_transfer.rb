# frozen_string_literal: true

require "test_helper"

class TestTransfer < Minitest::Test
  def setup
    @transfers_path = "/transferencias"
    @scheduled_transfers_path = "#{@transfers_path}/agendadas"
  end

  def test_create
    transfer_data = { amount: 100, recipient_id: "123456" }
    custom_token = "custom_token_example"
    mock = Minitest::Mock.new
    mock.expect :call, [], [@transfers_path, transfer_data, custom_token]

    Zspay::Transfer.stub :post, mock do
      Zspay::Transfer.create(transfer_data, custom_token)
    end

    mock.verify
  end

  def test_schedule_transfer
    transfer_id = "123"
    custom_token = "custom_token_example"
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@scheduled_transfers_path}/#{transfer_id}", custom_token]

    Zspay::Transfer.stub :get, mock do
      Zspay::Transfer.schedule_transfer(transfer_id, custom_token)
    end

    mock.verify
  end

  def test_remove
    transfer_id = "123"
    custom_token = "custom_token_example"
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@scheduled_transfers_path}/#{transfer_id}", custom_token]

    Zspay::Transfer.stub :delete, mock do
      Zspay::Transfer.remove(transfer_id, custom_token)
    end

    mock.verify
  end
end
