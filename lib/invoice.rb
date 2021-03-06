require_relative '../lib/invoice_repository'

class Invoice
    attr_reader :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at,
                :invoice_repo

  def initialize(invoice_data, invoice_repo)
    @id = invoice_data[:id].to_i
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status = invoice_data[:status].to_sym
    @created_at = Time.parse(invoice_data[:created_at].to_s)
    @updated_at = Time.parse(invoice_data[:updated_at].to_s)
    @invoice_repo = invoice_repo
  end

  def items
    @invoice_repo.items_from_invoice(id)
  end

  def merchant
    @invoice_repo.merchant_from_invoice(self.merchant_id)
  end

  def transactions
    @invoice_repo.transactions_from_invoice(id)
  end

  def customer
    @invoice_repo.customer_from_invoice(customer_id)
  end

  def is_paid_in_full?
    transactions.any?{|trans| trans.result == "success"}
  end

  def total
    if is_paid_in_full?
      @invoice_repo.total_from_invoice(id)
    end
  end
end
