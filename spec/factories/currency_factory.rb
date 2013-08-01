FactoryGirl.define do
  factory :currency, class: Spree::Currency do
    trait :usd do
      name 'dollars'
      char_code 'USD'
      num_code 624
      locale 'en'
      basic true
    end

    trait :rub do
      name 'rubles'
      char_code 'RUB'
      num_code 623
      locale 'ru'
      basic false
    end
  end
end
