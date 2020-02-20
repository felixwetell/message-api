class User < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false
  has_secure_password

  before_save :downcase_name

  has_many :messages, foreign_key: :user_id

  def downcase_name
    self.name = self.name.downcase.delete( ' ' )
  end
end
