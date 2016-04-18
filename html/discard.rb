require 'nokogiri'

class Discard
  attr_reader :player, :action
  def initialize(player, action)
    @player = player
    @action = action
  end

  def discard_cards
    discard = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          doc.title 'RFTG - Discard cards'
          doc.link :type => 'text/css', :rel => 'stylesheet', :href => '../css/style.css'
        end

        doc.body do
          doc.h1 "#{@player}'s turn: discard cards", :class => 'header'

          doc.p 'Six cards have been drawn, please discard two:'

          doc.div :class => "packed_cards" do
            6.times do |_|
              doc.img :class => "drawn_card", :src => 'http://jolabistouille.j.o.pic.centerblog.net/45777f7a.png'
            end

            doc.form :action => "/#{@action}", :method => "POST" do
              doc.input :class => "confirm", :type => "submit", :value => "Confirm discarded cards"
            end
          end

          doc.img :class => "illustration", :src => 'http://i.livescience.com/images/i/000/049/468/original/aliens-ET.jpg'
        end
      end
    end
    [discard.to_html]
  end
end
