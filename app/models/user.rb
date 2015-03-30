class User < ActiveRecord::Base
	require 'socket'

	has_many :comments

	def self.create_user
		# This method here was working earlier to retreive my IP information, for some reason
		# It is not pulling it anymore, earlier I saw that it pulled 127.0.0.1
		ipaddress = Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]
		user = User.create(ipaddress: ipaddress)
		user.update_attributes(username: "AnonymousUser#{user.id}")
		user
	end

	def change_user_name(new_username)
		self.update_attributes(username: new_username)
	end

	def update_active_users
		last_user_comment = Comment.where("user_id = ?", self.id).last
		if (Time.now - last_user_comment.created_at) > 120
			self.update_attributes(active: false)
		else
			self.update_attributes(active: true)
		end
	end

end
