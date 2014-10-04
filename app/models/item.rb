class Item < ActiveRecord::Base
  belongs_to :todo

  validates :description, length: {minimum: 8}, presence: true
  validates :todo, presence: true

  every :hour do
    # if (self.due_date > hour) 
  end
end
