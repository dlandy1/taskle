namespace :items do

  desc "Delete items after 7 days"
  task delete_items: :environment do
     Item.where("created_at <= ?", Time.now - 2.hours).destroy_all
  end

  desc "Tweet after 5 days"
  task tweet_items: :environment do
    @items = Item.where("created_at <= ?", Time.now - 2.hours).all
    @items.each do |item|
      @user = item.todo.user
      @user.tweet("I must #{item.description} soon")
    end
  end
   
end
