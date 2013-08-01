# coding: utf-8
require 'spec_helper'

feature 'Buy' do
  given!(:user) { create(:user) }
  given!(:usd)  { create(:currency, :usd) }
  given!(:rub)  { create(:currency, :rub) }

  background do
    Spree::CurrencyConverter.add(rub, Time.now, 1.0, 32.0)

    zone = create(:zone, name: 'CountryZone')
    @ship_cat = create(:shipping_category, name: 'all')
    @product  = create(:product, name: 'Rails Mug')
    @product.shipping_category = @ship_cat
    @product.save!
    @product.prices.each {|x| puts x.to_yaml }
    stock = @product.stock_items.first
    stock.adjust_count_on_hand(100)
    stock.save!

    @country = create(:country, iso_name: 'SWEDEN', name: 'Sweden', iso: 'SE', iso3: 'SE', numcode: 46)
    @country.states_required = false
    @country.save!
    @state = @country.states.create(name: 'Stockholm')
    zone.members.create(zoneable: @country, zoneable_type: 'Country')

    ship_meth = create(:shipping_method, calculator_type: 'Spree::Calculator::Shipping::FlatRate', display_on: 'both')
    ship_meth.zones << zone
    ship_meth.shipping_categories << @ship_cat
    ship_meth.calculator.preferred_amount = 90
    ship_meth.save!

    @pay_method = create(:payment_method)
  end

  context 'using different currencies' do
    xscenario 'products without price not visible' do
      Spree::Config[:show_products_without_price] = false
      visit '/'
      expect(page).to have_no_content @product.name
    end

    scenario 'products without price visible' do
      Spree::Config[:show_products_without_price] = true
      visit '/'
      expect(page).to have_content @product.name
    end

    context 'change currency on product page' do
      xscenario 'using rubler' do
        visit '/currency/RUB'
        expect(page).to have_content 'руб'
      end

      xscenario 'using dollar' do
        visit '/currency/USD'
        expect(page).to have_content 'USD'
      end
    end

    xscenario 'can checkout using selected currency' do
      visit '/'
      click_link @product.name, exact: false
      click_button 'add-to-cart-button'
      click_button 'checkout-link'

      # guest checkout
      fill_in 'order_email', with: user.email
      click_button 'Continue'

      # fill addresses
      # copy from spree/backend/spec/requests/admin/orders/order_details_spec.rb
      # may will in future require update
      check 'order_use_billing'
      fill_in 'order_bill_address_attributes_firstname', with: user.firstname
      fill_in 'order_bill_address_attributes_lastname',  with: user.lastname
      fill_in 'order_bill_address_attributes_address1',  with: user.address1
      fill_in 'order_bill_address_attributes_address2',  with: user.address2
      fill_in 'order_bill_address_attributes_city',      with: user.city
      fill_in 'order_bill_address_attributes_zipcode',   with: user.zipcode
      fill_in 'order_bill_address_attributes_phone',     with: user.phone
      within('fieldset#billing') do
        select @country.name, from: 'Country'
      end

      click_button 'Save and Continue'

      # shipping
      click_button 'Save and Continue'

      # payment page
      # fill_in 'social_security_number', with: '410321-9202'
      click_button 'Save and Continue'
    end
  end
end
