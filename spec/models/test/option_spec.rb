require 'rails_helper'

describe Test::Option do
  describe 'Associations' do
    it { should belong_to :question }
  end

  describe 'Validations' do
  end
end
