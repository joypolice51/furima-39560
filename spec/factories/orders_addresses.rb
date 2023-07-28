FactoryBot.define do
  factory :order_address do
    association :user
    association :item
    postal_code {'123-4567'}
    prefecture_id {1}
    city {'横浜市'}
    house_number {'高野山1-5-6'}
    phone_number {12345678910}
    building_name {'虎ノ門ヒルズ'}
    token {"tok_abcdefghijk00000000000000000"}
  end
end