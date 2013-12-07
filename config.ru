$LOAD_PATH.unshift "lib"

require "blog"
require "rack/cache"

use Rack::Cache
run Blog
