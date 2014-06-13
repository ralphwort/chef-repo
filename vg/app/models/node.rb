class Node < ActiveRecord::Base
	  belongs_to :openstack_user

	def self.for_openstack_user(openstack)
		where("openstack_user_id = #{openstack}")
  end


end
