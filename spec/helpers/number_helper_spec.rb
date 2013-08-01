# coding: utf-8
require 'spec_helper'

describe ActionView::Helpers::NumberHelper do
  context 'number_to_currency' do
    before do
      create(:currency, :usd)
      create(:currency, :rub)
    end

    it 'have correct format for dollar' do
      I18n.locale = :en
      Spree::Currency.current!
      number_to_currency(100.2).should eq '$100.20'
      number_to_currency(-2.12).should eq '-2.12 $'
    end

    xit 'have correct format for ruble' do
      I18n.locale = :ru
      Spree::Currency.current!
      number_to_currency(10).should eq '10.00 руб.'
      number_to_currency('11').should eq '11.00 руб.'
      number_to_currency(-10.23).should eq '-10.23 руб.'
    end
  end
end
