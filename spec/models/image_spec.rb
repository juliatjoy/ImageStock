require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'DB Table' do
    it {is_expected.to have_db_column(:uuid).of_type(:string)}
  end

  describe 'Associations' do
    it { should have_one(:file) }
  end

  # describe 'Attachment' do
  #   it 'is valid  ' do
  #     subject.file.attach(io: File.open(fixture_path + '/dummy_image.jpg'), filename: 'attachment.jpg', content_type: 'image/jpg')
  #     expect(subject.file).to be_attached
  #   end
  # end
end
