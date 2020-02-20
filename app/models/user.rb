class User < ApplicationRecord
  has_secure_password

  validates_presence_of :name, :password_digest
  validates_uniqueness_of :name, case_sensitive: false

  before_save :downcase_name

  has_many :messages, foreign_key: :user_id

  def downcase_name
    self.name = self.name.downcase.delete( ' ' )
  end
end
