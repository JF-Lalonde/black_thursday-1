require_relative '../lib/sales_engine'

class SalesAnalyst

  attr_reader :sales_engine,
              :avg_items

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @avg_items = @sales_engine.merchants.all_merchant_data.map do |merch|
    merch.items.count
  end
    (avg_items.reduce{|sum, num| sum + num}.to_f / avg_items.count).round(2)
  end

  def average_items_per_merchant_standard_deviation

  end
end
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
sa = SalesAnalyst.new(se)
puts sa.average_items_per_merchant