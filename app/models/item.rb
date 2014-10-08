class Item < ActiveRecord::Base
  belongs_to :todo

  validates :description, length: {minimum: 3, maximum: 40}, presence: true
  validates :todo, presence: true

end
