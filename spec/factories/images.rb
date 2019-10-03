FactoryBot.define do
  factory :image do
    trait :with_file do
      file { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'image.jpg'), 'image/jpeg') }
    end
  end
end