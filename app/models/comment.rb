class Comment < ActiveRecord::Base
	belongs_to :user

	def self.new_comment(comment, user_id)
		user = User.find(user_id)
		Comment.create(comment: comment, user_id: user_id, ipaddress: user.ipaddress)
	end
end
