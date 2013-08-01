# coding: utf-8
require 'spec_helper'

feature 'Currencies changing', js: true do
  given!(:usd) { create(:currency, :usd) }
  given!(:rub) { create(:currency, :rub) }

  background do
    Spree::CurrencyConverter.add(rub, Time.now, 1.0, 32.0)
  end

  scenario 'changes price when changing locale' do
    product = create(:product, cost_price: 1)
    variant = product.master
    I18n.locale = :en
    variant.cost_price.should eql 1.0
    I18n.locale = :ru
    Spree::Currency.current!
    Spree::Currency.current.should eql rub
    variant.cost_price.to_f.should eql 32.0
  end

  scenario 'check save master_price' do
    I18n.locale = :en
    Spree::Currency.current!
    product = create(:product, price: 123.54)
    product.reload
    product.price.should eql 123.54
    product.master.price.should eql 123.54
    I18n.locale = :ru
    Spree::Currency.current!
    product.price.should eql 3953.28
    product.master.price.should eql 3953.28
  end
end
