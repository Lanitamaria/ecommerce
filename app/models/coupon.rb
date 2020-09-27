class Coupon < ApplicationRecord
  belongs_to :user, optional: true

  kind massive o target
  code
  amount percent or fixed-amount
  discount kind
  user only
  count how many times

  def self.usable?
    valid_on_count?
  end

  def valid_on_count?
    kind.eq?('target') ? count > 0 : true
  end

  def compute_total(total)
    if discount.eq?('percent')
      percent_value = amount.to_f / 100
      total = total - (total * percent_value)
    else
      total = total - amount
      (total < 0 ) ? 0 : total
    end
  end

  def disabled
    coupon.available = false
    coupon.save!
  end

end

#  antes de pagar
coupon = Coupon.find_by(code: get_code_from_params)
if coupon.available?
  price = coupon.compute_total( order.total )
end

# despues de pagar
if coupon.kind.eq?('target')
  coupon.disabled
end