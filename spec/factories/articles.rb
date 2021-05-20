FactoryBot.define do
  factory :article do
    title { "MyString" }
    description { "MyString" }
    body { "MyText" }
    state { 1 }
    user { nil }
  end
end
