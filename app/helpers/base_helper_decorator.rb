Spree::BaseHelper.class_eval do
  def display_price(product_or_variant)
    product_or_variant.price_in(Spree::Currency.current).money.to_html
  end
end
