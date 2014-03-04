$LOAD_PATH.unshift "lib"

require "blog"
require "rack/cache"
require "newrelic_rpm"
NewRelic::Agent.after_fork(:force_reconnect => true)

use Rack::Cache
run Blog
