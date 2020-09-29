class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method

  def closed!
    ActiveRecord::Base.transaction do
      order.completed!
      completed!
    end
  end

  def completed!
    update_attribbutes({state: "completed"})
  end
end
