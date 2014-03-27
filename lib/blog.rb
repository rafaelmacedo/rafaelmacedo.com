require "digest"
require "ostruct"
require "redcarpet"
require "sinatra/base"
require "time"
require "yaml"

class Blog < Sinatra::Base

  set :app_file, __FILE__
  set :posts, []
  set :talks, []
  set :root, File.expand_path("../../", __FILE__)

  before do
    cache_control :public, :must_revalidate
    etag Digest::MD5.hexdigest(settings.posts.to_s)
    last_modified settings.posts.first.date
  end

  helpers do
    def title
      "[rafaelmacedo.com] "
    end

    def subtitle(locals)
      subtitle = ["~/"]
      if locals[:post]
        subtitle.push "posts"
        subtitle.push locals[:post].title
      elsif locals[:talks]
        subtitle.push "talks"
      end
      subtitle.join("/").squeeze("/")
    end
  end

  get("/") { erb :index }

  get("/talks") { erb :talks, locals: { talks: settings.talks } }

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

  Dir.glob "#{root}/talks/*.md" do |file|
    meta, content = File.read(file).split("\n\n", 2)
    talk = OpenStruct.new YAML.load(meta)
    talk.content = content
    talks << talk
  end
end
