Spree::Core::ControllerHelpers::Order.class_eval do
  def current_currency
    Spree::Currency.current.try(:char_code) || Spree::Config[:currency]
  end
end
