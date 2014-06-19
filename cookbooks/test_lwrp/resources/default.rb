actions :create, :remove

attribute :contents, kind_of: String, default: "Hello World"
attribute :path, kind_of: String, default: "/tmp/greeting.txt"
