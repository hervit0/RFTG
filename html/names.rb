require 'nokogiri'

class Names
  attr_reader :players_number
  def initialize(players_number)
    @players_number = players_number
  end

  def give_name
    names = Nokogiri::HTML::Builder.new do |doc|

      doc.html {
        doc.head {
          doc.title 'RFTG - Names of the players'
          link = doc.link
          link['type'] = 'text/css'
          link['rel'] = 'stylesheet'
          link['href'] = '../css/style.css'
        }

        doc.body {
          doc.h1 'Race for the galaxy', :class => 'header'

          doc.p 'Please enter the name of each player.'
          players_names_form = doc.form {
            #names = (1..@players_number).map { |x| 'name_player#{x}' }
            @players_number.times do |x|
              doc.p "Name of player #{x+1}:"
              doc.input :type => 'text'
            end
            doc.p ''
            confirm_name = doc.input
            confirm_name['class'] = 'confirm'
            confirm_name['type'] = 'submit'
            confirm_name['value'] = 'Confirm names of players'
          }
          #players_names_form['action'] = 

          pic_names = doc.img
          pic_names['class'] = 'illustration'
          pic_names['src'] = 'http://i.livescience.com/images/i/000/049/468/original/aliens-ET.jpg'
        }
      }
    end
    names.to_html
  end
end

File.write("test.html", Names.new(2).give_name)
