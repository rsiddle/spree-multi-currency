# Spree Multi-Currency (Slim edition)

[![Build Status](https://travis-ci.org/futhr/spree-multi-currency.png)](https://travis-ci.org/futhr/spree-multi-currency)
[![Dependency Status](https://gemnasium.com/futhr/spree-multi-currency.png)](https://gemnasium.com/futhr/spree-multi-currency)
[![Coverage Status](https://coveralls.io/repos/futhr/spree-multi-currency/badge.png?branch=master)](https://coveralls.io/r/futhr/spree-multi-currency)

Provides UI to allow configuring multiple currencies in Spree. This is the slim edition without extended currency converters.

This provides 3 preferences:

* allow_currency_change - Allow the users to change their currency via the currency set action.
* show_currency_selector - Display the currency selector in the main nav bar. This will only display if there are multiple supported currencies, and allow_currency_change is on.
* supported_currencies - A comma separated list of.

## Installation

To install you'll need to add the following to your `Gemfile`:
```ruby
gem 'spree_multi_currency', github: 'prosnix/spree-multi-currency'
```

Run:

    $ bundle install

And then run:

    $ rails generate spree_multi_currency:install

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
[2]: https://github.com/spree/spree_multi_currency/issues
[3]: https://github.com/spree/spree_multi_currency/tree/master/LICENSE.md
[4]: http://www.localeapp.com/projects/5369
[5]: https://github.com/thoughtbot/guides
