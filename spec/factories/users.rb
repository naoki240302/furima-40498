FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.email }
    password              { 'n7' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    kana_last             { person.last.katakana }
    kana_first            { person.first.katakana }
    birthday              { Faker::Date.backward }
  end
end
