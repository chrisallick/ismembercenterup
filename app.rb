require 'open-uri'

EM.run do
    class App < Sinatra::Base
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

        get '/test' do
            if params[:pw] == "vanilla69"
                Pony.mail({
                  :to => '4153006890@txt.att.net',
                  :body => "Apple Member Center Is Up",
                  :via => :smtp,
                  :via_options => {
                    :address              => 'smtp.gmail.com',
                    :port                 => '587',
                    :enable_starttls_auto => true,
                    :user_name            => 'ismembercenterup@gmail.com',
                    :password             => 'asdf123!89',
                    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
                    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
                  }
                })
                "nice"
            else
                "nope"
            end
        end
    end

    EventMachine.add_periodic_timer(3600) {
        doc = Nokogiri::HTML(open('https://developer.apple.com/support/system-status/'))
        answer = true
        doc.search("td.offline span").each do |span|
            if span.content == "Member Center"
                answer = false
            end
        end
        if answer
            Pony.mail({
              :to => '4153006890@txt.att.net',
              :body => "Apple Member Center Is Up",
              :via => :smtp,
              :via_options => {
                :address              => 'smtp.gmail.com',
                :port                 => '587',
                :enable_starttls_auto => true,
                :user_name            => 'ismembercenterup@gmail.com',
                :password             => 'asdf123!89',
                :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
                :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
              }
            })
        end
    }

    #Thin::Server.start App, '0.0.0.0', 3000
end