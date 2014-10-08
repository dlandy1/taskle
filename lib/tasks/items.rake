namespace :items do

  desc "Delete items after 7 days"
  task delete_items: :environment do
     Item.where("created_at <= ?", Time.now - 2.hours).destroy_all
  end

  # desc "Tweet after 5 days"
  # task delete_items: :environment do
   
end
