class Todo < ActiveRecord::Base
  has_many :items, dependent: :destroy
   belongs_to :user



  validates :title, length: {minimum: 3}, presence: true
   validates :user, presence: true
end
