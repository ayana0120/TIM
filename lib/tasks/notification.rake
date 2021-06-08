namespace :task do
  desc "期限通知のための確認"
  task :notification => :environment do
  	today = Time.current
  	items = Item.all

  	items.each do |item|
  	  @user = item.user
      if item.deadline.nil?
        if today.since(3.days).to_date == item.exp
          Notification.create(item_id: item, user_id: @user, action: "warning")
          NotificationMailer.warning(@user, item).deliver_now
        elsif today.to_date == item.exp
          item.notifications.update(action: "expired")
          NotificationMailer.expired(@user, item).deliver_now
        end
      else
    	  if today.since(item.deadline.days).to_date == item.exp
    	  	Notification.create(item_id: item, user_id: @user, action: "warning")
    	  	NotificationMailer.warning(@user, item).deliver_now
    	  elsif today.to_date == item.exp
    	  	item.notifications.update(action: "expired")
    	  	NotificationMailer.expired(@user, item).deliver_now
    	  end
      end
  	end
  end
end
