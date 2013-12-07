require "git_hook"
require "ostruct"
require "sinatra/base"
require "time"

class Blog < Sinatra::Base
  use GitHook

  set :app_file, __FILE__
  set :articles, []
  set :root, File.expand_path("../../", __FILE__)

  Dir.glob "#{root}/articles/*.md" do |file|
    meta, content = File.read(file).split("\n\n", 2)

    article         = OpenStruct.new YAML.load(meta)
    article.content = content
    article.data    = Time.parse article.date.to_s
    article.slug    = File.basename file, ".md"

    get("/#{article.slug}") { erb :post, locals: { article: article } }

    articles << article
  end

  articles.sort_by { |article| article.date }
  articles.reverse!

  get("/") { erb :index }
end
