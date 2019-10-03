require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'Associations' do
    it { should have_one(:file_attachment) }
  end
end
