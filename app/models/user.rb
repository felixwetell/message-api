class User < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false
  has_secure_password

  before_save :downcase_name

  def downcase_name
    self.name = self.name.strip.downcase
  end
end