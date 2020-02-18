class Message < ApplicationRecord
  validates_presence_of :title, :text, :author
end
