require 'nokogiri'

class Discard
  attr_reader :player
  def initialize(player)
    @player = player
  end

  def discard_cards
    discard = Nokogiri::HTML::Builder.new do |doc|

      doc.html {
        doc.head {
          doc.title 'RFTG - Discard cards'
          link = doc.link
          link['type'] = 'text/css'
          link['rel'] = 'stylesheet'
          link['href'] = '../css/style.css'
        }

        doc.body {
          doc.h1 "#{@player}'s turn: discard cards", :class => 'header'

          doc.p 'Six cards have been drawn, please discard two:'

          doc.div {
            6.times do |_|
              cat = doc.img
              cat['src'] = 'http://jolabistouille.j.o.pic.centerblog.net/45777f7a.png'
              cat['class'] = 'drawn_card'
            end
          }['class'] = 'packed_cards'

          confirm_discard = doc.input
          confirm_discard['class'] = 'confirm'
          confirm_discard['type'] = 'submit'
          confirm_discard['value'] = 'Confirm discarded cards'

          pic_names = doc.img
          pic_names['class'] = 'illustration'
          pic_names['src'] = 'http://i.livescience.com/images/i/000/049/468/original/aliens-ET.jpg'
        }
      }
    end
    discard.to_html
  end
end

File.write("test.html", Discard.new("Toto").discard_cards)
