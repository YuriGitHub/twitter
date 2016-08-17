class DeleteBlockedUserJob < ActiveJob::Base
  queue_as :default

  def perform
    blocked_users = User.where.not(locked_at: nil)
    blocked_users.each do |user|
      
      if user.deleted_at == nil and ( Time.now - user.locked_at ) > ( 5 * 24 * 60 * 60 )
        user.deleted_at = Time.now
        user.save
        puts "----------------------------"
      end
    end
  end
end

