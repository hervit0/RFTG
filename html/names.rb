require 'nokogiri'

class Names
  attr_reader :players_number
  def initialize(players_number)
    @players_number = players_number
  end

  def give_name
    names = Nokogiri::HTML::Builder.new do |doc|

      doc.html  do
        doc.head  do
          doc.title 'RFTG - Names of the players'
          doc.link :type => 'text/css', :rel => 'stylesheet', :href => '../css/style.css'
        end

        doc.body  do
          doc.h1 'Race for the galaxy', :class => 'header'

          doc.p 'Please enter the name of each player.'
          doc.form :action => '/discard', :method => 'POST' do
            @players_number.times do |x|
              doc.p "Name of player #{x+1}:"
              doc.input :type => 'text', :name => "player_name#{x+1}"
            end
            doc.input :type => 'submit', :class => 'confirm', :value => 'Confirm number of player'

          end

          doc.img :class => 'illustration', :src => 'http://i.livescience.com/images/i/000/049/468/original/aliens-ET.jpg'
        end
      end
    end
    [names.to_html]
  end
end
