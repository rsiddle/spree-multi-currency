module Spree
  module MultiCurrency
    # Order.class_eval do
    # extend MultiCurrency
    # multi_currency :item_total, :total,
    #                :rate_at_date => lambda{ |t| t.created_at },
    #                :only_read => true
    #  only_read - define just the getter method (and not the setter)
    #  rate_at_date - use the exchange rate at the specified date
    def multi_currency(*args)
      options = args.extract_options!

      [args].flatten.compact.each do |number_field|

        # define for example method price
        define_method(number_field.to_sym) do
          if options.has_key?(:rate_at_date) && options[:rate_at_date].is_a?(Proc)
            Spree::Currency.conversion_to_current(
              read_attribute(number_field.to_sym),
              { date: options[:rate_at_date].call(self) }
            )
          else
            Spree::Currency.conversion_to_current(read_attribute(number_field.to_sym))
          end
        end

        unless options[:only_read]
          define_method(:"#{number_field}=") do |value|
            write_attribute(number_field.to_sym, Spree::Currency.conversion_from_current(value))
          end
        end
      end
    end
  end
end

module SpreeMultiCurrency
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_multi_currency'

    config.autoload_paths += %W(#{config.root}/lib)

    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      ['../../app/**/*_decorator*.rb', '../../lib/**/*_decorator*.rb'].each do |path|
        Dir.glob(File.join(File.dirname(__FILE__), path)) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end

      ApplicationController.send :include, Spree::CurrencyHelpers
    end

    config.to_prepare &method(:activate).to_proc
  end
end
