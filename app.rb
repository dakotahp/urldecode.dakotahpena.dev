require 'sinatra'

get '/' do
  File.open("#{Dir.pwd}/index.html", File::RDONLY).readlines
end
