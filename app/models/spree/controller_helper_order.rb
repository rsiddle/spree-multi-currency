Spree::Core::ControllerHelpers::Order.class_eval do
  def current_currency
    Spree::Currency.current.char_code
  end
end
