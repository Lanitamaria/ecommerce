require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'payments is marked is completed' do
    user_one = User.create(email 'user@mail.com', password: 'password')
    order = Order.create(user: user_one, total: 100)

    pm = PaymentMethod.create(name: 'Paypal Express', code: 'PEC')
    payment = Payment.create(order_id: order.id, payment_method_id: pm.id, state: 'processing', total: 100, token: 'token_123')

    payment.completed!
    assert_equal payment.state, 'completed'
  end

  test 'complete payment' do
    user_one = User.create(email 'user@mail.com', password: 'password')
    order = Order.create(user: user_one, total: 100)

    pm = PaymentMethod.create(name: 'Paypal Express', code: 'PEC')
    payment = Payment.create(order_id: order.id, payment_method_id: pm.id, state: 'processing', total: 100, token: 'token_123')

    payment.closed!
    assert_equal payment.state, 'completed'
    assert_equal payment.order.state, 'completed'
  end
end
