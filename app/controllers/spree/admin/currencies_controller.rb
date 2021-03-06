module Spree
  module Admin
    class CurrenciesController < ResourceController
      before_filter :set_currency, only: [:edit, :update]

      private

      def set_currency
        @currency = Spree::Currency.find(params[:id])
      end
    end
  end
end
