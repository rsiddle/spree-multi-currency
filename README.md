# Spree Multi-Currency

[![Build Status](https://travis-ci.org/futhr/spree-multi-currency.png?branch=2-0-stable)](https://travis-ci.org/futhr/spree-multi-currency)
[![Dependency Status](https://gemnasium.com/futhr/spree-multi-currency.png)](https://gemnasium.com/futhr/spree-multi-currency)
[![Coverage Status](https://coveralls.io/repos/futhr/spree-multi-currency/badge.png?branch=2-0-stable)](https://coveralls.io/r/futhr/spree-multi-currency)

Provides UI to allow configuring multiple currencies in Spree and support different currency and recalculate price from one to another.

## Installation

Add to `Gemfile`
```ruby
gem 'spree_multi_currency', github: 'futhr/spree-multi-currency', branch: '2-0-stable'
```

Alternative branch without currency convertors

```ruby
gem 'spree_multi_currency', github: 'futhr/spree-multi-currency', branch: '2-0-stable-slim-edition'
```

Run

    rails g install:spree_multi_currency

### Load currencies:

Load up the list of all international currencies with corresponding codes:

    rake spree_multi_currency:currency:iso4217 # Load currency ISO4217
    rake spree_multi_currency:currency:okv     # Central Bank of Russian Federation

This step is not obligatory, i.e. you can manually fill up the 'currencies' table, but it's more practical to load the list with rake task above (and be sure the codes are OK), and then remove the currencies you don't want to support.

If you want get amount in base currency use base_total

### Load rates:

*Warning* Rates are being calculated relative to currency configured as 'basic'. It is therefore obligatory to visit Spree admin panel (or use Rails console) and edit one of the currencies to be the 'basic' one.

Basic currency is also the one considered to be stored as product prices, shipment rates etc., from which all the other ones will be calculated using the rates.

After setting the basic currency, time to load the rates using one of the rake tasks below. There are three sources of conversion rates supported by this extension:

1. Rates from Central Bank of Russian Federation http://www.cbr.ru. These assume Russian Ruble is your basic currency:
```
rake spree_multi_currency:rates:cbr
```

2. Rates from European Central Bank. These assume Euro is your basic currency:
```
rake spree_multi_currency:rates:ecb
```

3. Rates from Google.
```
rake spree_multi_currency:rates:google[currency]
```

  The argument in square brackets is the iso code of your basic currency, so to load rates when US Dollar is your basic currency, use
  ```
  rake spree_multi_currency:rates:google[usd]
  ```

  There's also an optional square-bracket-enclosed parameter "load_currencies" for :rates tasks above, but it just loads up currencies table from Wikipedia, so is not needed at this point.

## Settings

In Spree Admin Panel, Configuration tab, two new options appear: Currency Settings and Currency Converters.

It's best to leave Currency Converters as-is, to be populated and updated by rake spree_multi_currency:rates tasks.

Within Currency Settings, like mentioned above, it is essential to set one currency as the Basic one. It's also necessary to set currency's locale for every locale you want to support (again, one locale - one currency).
Feel free to go through currencies and delete the ones you don't want to support -- it will make everything easier to manage (and the :rates rake tasks will execute faster).

- In admin block, configuration menu add two tables currency and currency conversion rate
- In reference currency enters the list of currencies, indicate if one of the major currencies (in the currency keeps all prices). Each currency assign corresponding locale.
- In Exchange Rates, provides information on the price of the currency on a specified date to the basic currency(from russian central bank).
- In the exchange rates set date, currency, and face value of the currency in the base currency.
- To fill in the exchange rate, you can use task for download exchange rates from the site of the Central Bank (http://www.cbr.ru):
rake spree_multi_currencies:rates:cbr, as in this problem, loading the list of currencies.

### Changing Currency in store

Self-explanatory:
```ruby
# http://[domain]/currency/[isocode]
<%= link_to 'eur', currency_path(:eur) %>
```

### Translation files

To have custom currency symbols and formatters, you need to have a corresponding entry in one of locale files, with main key like currency_XXX, where XXX is the 3-letter iso code of given currency.

If you won't have it, all the other currencies will be rendered using default formatters and symbols, which can (will) lead to confusion and inconsistency. It is recommended to create locale entries for all currencies you want to support at your store and delete all the other currencies.

Example for usd, eur
```yml
---
currency_USD: &usd
  number:
    currency:
      format:
        format: "%u%n"
        unit: "$"
        separator: "."
        delimiter: ","
        precision: 2
        significant: false
        strip_insignificant_zeros: false

currency_EUR:
  <<: *usd
  number:
    currency:
      format:
        format: "%u%n"
        unit: "€"
```

## Contributing

In the spirit of [free software][1], **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs][2]
* by suggesting new features
* by writing [translations][4]
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues][2]
* by reviewing patches

Starting point:

* Fork the repo
* Clone your repo
* Run `bundle install`
* Run `bundle exec rake test_app` to create the test application in `spec/test_app`
* Make your changes and follow this [Style Guide][5]
* Ensure specs pass by running `bundle exec rspec spec`
* Submit your pull request

Copyright (c) 2013, Pronix LLC. and other contributors, released under the [New BSD License][3]

[1]: http://www.fsf.org/licensing/essays/free-sw.html
[2]: https://github.com/spree/spree-multi-currency/issues
[3]: https://github.com/spree/spree-multi-currency/blob/2-0-stable/LICENSE.md
[4]: http://www.localeapp.com/projects/4925
[5]: https://github.com/thoughtbot/guides
