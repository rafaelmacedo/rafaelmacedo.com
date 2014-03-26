require "digest"
require "ostruct"
require "redcarpet"
require "sinatra/base"
require "time"
require "yaml"

class Blog < Sinatra::Base

  set :app_file, __FILE__
  set :posts, []
  set :root, File.expand_path("../../", __FILE__)

  helpers do
    def title(post=nil)
      title = ["rafaelmacedo.com"]
      title.push post.title if post
      title.join(" - ")
    end
  end

  Dir.glob "#{root}/posts/*.md" do |file|
    meta, content = File.read(file).split("\n\n", 2)

    post         = OpenStruct.new YAML.load(meta)
    post.content = content
    post.date    = Time.parse post.date.to_s
    post.slug    = File.basename file, ".md"
    post.slug.gsub!(/\d{4}-\d{2}-\d{2}-/) { |match| match.gsub!("-", "/") }

    get("/#{post.slug}") { erb :post, locals: { post: post } }
    posts << post
  end

  posts.sort_by { |post| post.date }
  posts.reverse!

  before do
    cache_control :public, :must_revalidate
    etag Digest::MD5.hexdigest(posts.to_s)
    last_modified posts.first.date
  end

  get("/") { erb :index }
end
