require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many :messages }
  it { should validate_presence_of( :password ) }
  it { should validate_presence_of( :name ) }

  # Shoulda matchers can not validate uniqueness of column if record is empty, see source below
  # https://www.rubydoc.info/github/thoughtbot/shoulda-matchers/Shoulda%2FMatchers%2FActiveRecord%3Avalidate_uniqueness_of
  describe 'users name should be unique' do
    subject { FactoryBot.create( :user ) }
    it { should validate_uniqueness_of( :name ).ignoring_case_sensitivity }
  end
end
