# app/workers/bootstrap_instance.rb
class BootstrapInstance
  include Sidekiq::Worker

  def perform(exec_str, sleep_time)
	 	sleep(sleep_time)
    `#{exec_str}`
  end
end
