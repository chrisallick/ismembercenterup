require 'sinatra'
require 'sinatra/partial'
require 'sinatra/reloader' if development?
require 'open-uri'

get '/' do
    doc = Nokogiri::HTML(open('https://developer.apple.com/support/system-status/'))
    answer = "yes"
    doc.search("td.offline span").each do |span|
        if span.content == "Member Center"
            answer = "no"
        end
    end

    erb :main, :locals => {
        :answer => answer
    }
end