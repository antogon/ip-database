Warden::Strategies.add(:hybrid_override) do
      def valid?
        true
      end
 
      def authenticate!
				debugger
				if !:params['user'].nil?
					ldap = Net::LDAP.new
					ldap.host = '130.127.255.249' # IP for 'ldap.clemson.edu'
					ldap.port = 389
					ldap.auth :params['user']['username'], :params['user']['password']
					if ldap.bind
						success! :params['user']
					else
						fail! "It's a sad day in Crazytown."
					end
				else
					fail! "You should probs login..."
				end
      end
end
