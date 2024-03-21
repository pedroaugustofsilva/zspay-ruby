# frozen_string_literal: true

require "test_helper"

class TestSale < Minitest::Test
  def setup
    @sales_path = "/vendas"
  end

  def test_create
    sale_data = { amount: 100, currency: "BRL" }
    custom_token = "custom_token_example"
    mock = Minitest::Mock.new
    mock.expect :call, [], [@sales_path, sale_data, custom_token]

    Zspay::Sale.stub :post, mock do
      Zspay::Sale.create(sale_data, custom_token)
    end

    mock.verify
  end

  def test_show
    sale_id = "123"
    custom_token = "custom_token_example"
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@sales_path}/#{sale_id}", custom_token]

    Zspay::Sale.stub :get, mock do
      Zspay::Sale.show(sale_id, custom_token)
    end

    mock.verify
  end

  def test_refund
    sale_id = "123"
    custom_token = "custom_token_example"
    mock = Minitest::Mock.new
    mock.expect :call, [], ["#{@sales_path}/#{sale_id}/estornar", {}, custom_token]

    Zspay::Sale.stub :post, mock do
      Zspay::Sale.refund(sale_id, custom_token)
    end

    mock.verify
  end
end
