require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
          :items => "./test/data/items_truncated.csv",
          :merchants => "./test/data/merchants_truncated.csv",
          :invoice_items => "./test/data/invoice_items_truncated.csv",
          :invoices => "./test/data/invoices_truncated.csv",
          :transactions => "./test/data/transactions_truncated.csv",
          :customers => "./test/data/customers_truncated.csv"
        })
  end

  def test_that_sales_engine_is_right_class
    assert_equal SalesEngine, @se.class
  end

  def test_from_csv_returns_sales_engine
    assert_equal SalesEngine, @se.class
  end

  def test_items_creates_instance_of_item_repository
      assert_instance_of ItemRepository, @se.items
  end

  def test_merchants_creates_instance_of_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_sales_engine_can_access_merch_repo_methods
    actual = @se.merchants.find_by_id(12334105)
    expected = @se.merchants.all[0]

    assert_equal expected, actual
  end

  def test_sales_engine_can_access_array_of_items
    actual = @se.items.find_all_by_merchant_id(12334105)

    assert_equal Array, actual.class
  end

  def test_if_merchant_method_in_items_links_to_merchant_class
    item = @se.items.find_by_id(263395237)
    actual = item.merchant.class

    assert_equal Merchant, actual
  end

  def test_if_items_method_in_merchants_links_to_item_class
    merchant = @se.merchants.find_by_id(12334105)
    actual = merchant.items[0].class

    assert_equal Item, actual
  end

  def test_if_invoices_method_in_merchants_call_invoices
    merchant = @se.merchants.find_by_id(12334159)
    actual = merchant.invoices[0].class
    expected = Invoice

    assert_equal expected, actual
  end

  def test_if_merchant_method_in_invoices_returns_merchant
    invoice = @se.invoices.find_by_id(234)
    actual = invoice.merchant.class

    assert_equal Merchant, actual

  end

  def test_if_items_method_in_invoice_returns_items
    invoice = @se.invoices.find_by_id(3)
    actual = invoice.items[0].class

    assert_equal Item, actual
  end

  def test_if_transactions_from_invoice_return_transactions
    invoice = @se.invoices.find_by_id(14)
    actual = invoice.transactions[0].class

    assert_equal Transaction, actual
  end

  def test_if_customer_from_invoice_returns_customers
    invoice = @se.invoices.find_by_id(14)
    actual = invoice.customer.class

    assert_equal Customer, actual
  end

  def test_if_invoice_from_transaction_returns_invoice
    transaction = @se.transactions.find_by_id(40)
    actual = transaction.invoice.class

    assert_equal Invoice, actual
  end

  def test_if_customer_from_merchant_returns_customers
    merchant = @se.merchants.find_by_id(12334105)
    actual = merchant.customers[0].class

    assert_equal Customer, actual
  end

  def test_if_merchant_from_customer_returns_merchant
    customer = @se.customers.find_by_id(1)
    actual = customer.merchants[0].class

    assert_equal Merchant, actual
  end

  def test_if_invoice_is_paid_in_full
    invoice = @se.invoices.find_by_id(14)
    actual = invoice.is_paid_in_full?

    assert_equal true, actual

    invoice = @se.invoices.find_by_id(13)
    actual = invoice.is_paid_in_full?

    assert_equal false, actual
  end

  def test_invoice_total
    invoice = @se.invoices.find_by_id(14)
    actual = invoice.total

    assert_equal 22496.84, actual
  end
end
