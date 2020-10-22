namespace :task do
  desc "期限通知のための確認"
  task :notification => :environment do
  	today = Date.today
  	items = Item.all

  	items.each do |item|
  	  @user = item.user
  	  if today + 3 == item.exp
  	  	Notification.create(item_id: @item, user_id: @user, action: "warning")
  	  	NotificationMailer.warning(@user).deliver_now
  	  elsif today == item.exp
  	  	item.notifications.update(item_id: @item, user_id: @user, action: "expired")
  	  	NotificationMailer.expired(@user).deliver_now
  	  end
  	end
  end
end
