require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_starts_a_merchant_instance
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, merchant
  end

  def test_attr_reader_works
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal "Turing School", merchant.name
  end
end