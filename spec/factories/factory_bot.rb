require 'faker'

FactoryBot.define do
  factory :merchant do
    name { Faker::Name.unique.name }
  end

  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :invoice do
    status { Invoice.statuses.keys.sample }
    customer
  end

  factory :item do
    name { Faker::Cosmere.metal }
    description { Faker::Cosmere.shard }
    unit_price { Faker::Number.between(from: 1, to: 100000) }
    merchant
  end

  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Number.between(from: 1, to: 100000) }
    status { InvoiceItem.statuses.keys.sample }
    invoice
    item
  end

  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Date.forward(days: 3000) }
    result { Transaction.results.keys.sample }
    invoice
  end

  factory :bulk_discount do
    percentage_discount { Faker::Number.between(from: 1, to: 100) }
    quantity_threshold { Faker::Number.within(range: 10..100) }
    merchant
  end
end
