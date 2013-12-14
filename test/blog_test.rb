ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"
require "turn"
require File.expand_path "../../lib/blog.rb", __FILE__

Turn.config.format = :outline

class BlogTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Blog
  end

  def app_root
    File.expand_path("../../", __FILE__)
  end

  def posts
    posts_list = []
    Dir.glob "#{app_root}/posts/*.md" do |file|
      meta, content = File.read(file).split("\n\n", 2)
      post         = OpenStruct.new YAML.load(meta)
      post.slug    = File.basename file, ".md"
      post.slug.gsub!(/\d{4}-\d{2}-\d{2}-/) { |match| match.gsub!("-", "/") }
      posts_list << post
    end
    posts_list
  end

  def test_root_path
    get "/"
    assert last_response.ok?
    posts.each do |post|
      last_response.body.match %r{#{post.title}}
    end
  end

  def test_posts_path
    posts.each do |post|
      get post.slug
      assert last_response.ok?
      last_response.body.match %r{#{post.title}}
    end
  end
end
