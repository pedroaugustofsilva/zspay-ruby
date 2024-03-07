# frozen_string_literal: true

require "test_helper"

class TestBankAccount < Minitest::Test
  def setup
    @resource_path = "/estabelecimentos/contas_bancarias"
  end

  def test_index
    mock = Minitest::Mock.new
    mock.expect :call, [], [@resource_path]

    Zspay::BankAccount.stub :get, mock do
      Zspay::BankAccount.index
    end

    mock.verify
  end

  def test_create
    account = { name: "Example" }
    mock = Minitest::Mock.new
    mock.expect :call, [], [@resource_path, account]

    Zspay::BankAccount.stub :post, mock do
      Zspay::BankAccount.create(account)
    end

    mock.verify
  end

  def test_active
    account_id = 1
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@resource_path}/#{account_id}/ativar"]

    Zspay::BankAccount.stub :post, mock do
      Zspay::BankAccount.active(account_id)
    end

    mock.verify
  end

  def test_destroy
    establishment_id = 1
    account_id = 1
    mock = Minitest::Mock.new
    mock.expect :call, [], ["/estabelecimentos/#{establishment_id}/contas_bancarias/#{account_id}/excluir"]

    Zspay::BankAccount.stub :delete, mock do
      Zspay::BankAccount.destroy(establishment_id, account_id)
    end

    mock.verify
  end
end
