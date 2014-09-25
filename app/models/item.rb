class Item < ActiveRecord::Base
  belongs_to :todo
  belongs_to :grouptodo

  validates :title, length: {minimum: 8}, presence: true
  validates :todo, presence: true
  validates :grouptodo, presence: true
end
