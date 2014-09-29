class Item < ActiveRecord::Base
  belongs_to :todo

  validates :title, length: {minimum: 8}, presence: true
  validates :todo, presence: true
end
