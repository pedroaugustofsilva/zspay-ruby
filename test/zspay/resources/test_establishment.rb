# frozen_string_literal: true

require "test_helper"

class TestEstablishment < Minitest::Test
  def setup
    @base_path = "/estabelecimentos"
  end

  def test_child_establishments
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@base_path}/filhos"]

    Zspay::Establishment.stub :get, mock do
      Zspay::Establishment.index
    end

    mock.verify
  end

  def test_create
    establishment_data = { name: "Example Establishment" }
    mock = Minitest::Mock.new
    mock.expect :call, [], [@base_path, establishment_data, { body: "form" }]

    Zspay::Establishment.stub :post, mock do
      Zspay::Establishment.create(establishment_data)
    end

    mock.verify
  end

  def test_active
    establishment_id = "123"
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@base_path}/#{establishment_id}/habilitar"]

    Zspay::Establishment.stub :post, mock do
      Zspay::Establishment.active(establishment_id)
    end

    mock.verify
  end

  def test_delete
    establishment_id = "123"
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@base_path}/#{establishment_id}"]

    Zspay::Establishment.stub :delete, mock do
      Zspay::Establishment.disable(establishment_id)
    end

    mock.verify
  end

  def test_token
    establishment_id = "123"
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@base_path}/#{establishment_id}/token"]

    Zspay::Establishment.stub :get, mock do
      Zspay::Establishment.token(establishment_id)
    end

    mock.verify
  end

  def test_balance
    establishment_id = "123"
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@base_path}/#{establishment_id}/saldo"]

    Zspay::Establishment.stub :get, mock do
      Zspay::Establishment.balance(establishment_id)
    end

    mock.verify
  end

  def test_search_by_document
    document = "12345678901"
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@base_path}/por_documento/#{document}"]

    Zspay::Establishment.stub :get, mock do
      Zspay::Establishment.search_by_document(document)
    end

    mock.verify
  end
end
