Spree::Core::ControllerHelpers::Order.class_eval do
  def current_currency
    Spree::Currency.current
  end
end
