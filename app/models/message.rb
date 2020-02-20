class Message < ApplicationRecord
  validates_presence_of :title, :text, :author, :user_id

  belongs_to :user
end
