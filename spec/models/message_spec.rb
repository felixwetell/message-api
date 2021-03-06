require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should validate_presence_of( :title ) }
  it { should validate_presence_of( :text ) }
  it { should validate_presence_of( :author ) }
  it { should validate_presence_of( :user_id ) }
end
