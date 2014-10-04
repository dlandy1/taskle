class Item < ActiveRecord::Base
  belongs_to :todo

  validates :description, length: {minimum: 3}, presence: true
  validates :todo, presence: true

end
