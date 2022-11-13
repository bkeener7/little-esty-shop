require 'faker'

FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Name.name }
  end

  factory :customer, class: Customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :invoice, class: Invoice do
    status { rand(0..2) }
    association :customer, factory: :customer
  end

  factory :item, class: Item do
    name { Faker::Cosmere.metal }
    description { Faker::Cosmere.shard }
    unit_price { Faker::Number.between(from: 1, to: 100000) }
    association :merchant, factory: :merchant
  end

  factory :invoice_item, class: InvoiceItem do
    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Number.between(from: 1, to: 100000) }
    status { rand(0..2) }
    association :invoice, factory: :invoice
    association :item, factory: :item
  end

  factory :transaction, class: Transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Date.forward(days: 3000) }
    result { rand(0..1) }
    association :invoice, factory: :invoice
  end
end
