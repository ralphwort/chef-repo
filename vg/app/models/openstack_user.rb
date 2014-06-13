class OpenstackUser < ActiveRecord::Base
	has_many :nodes
end
