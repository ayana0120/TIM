namespace :task do
  desc "期限通知のための確認"
  task :notification => :environment do
  	today = Date.today
  	items = Item.all

  	items.each do |item|
  	  @user = item.user
  	  if today.since(3.days).to_date == item.exp
  	  	Notification.create(item_id: @item, user_id: @user, action: "warning")
  	  	NotificationMailer.warning(@user, item).deliver_now
  	  elsif today == item.exp
  	  	item.notifications.update(action: "expired")
  	  	NotificationMailer.expired(@user, item).deliver_now
  	  end
  	end
  end
end
