require 'nokogiri'
require_relative 'names.rb'

class Welcome
  def self.display
    welcome = Nokogiri::HTML::Builder.new do |doc|

      doc.html {
        doc.head {
          doc.title 'RFTG - Welcome'
          link = doc.link
          link['type'] = 'text/css'
          link['rel'] = 'stylesheet'
          link['href'] = '../css/style.css'
        }

        doc.body {
          doc.h1 'Race for the galaxy', :class => 'header'
          doc.p 'Welcome on Race for the galaxy board game.'

          pic_intro = doc.img
          pic_intro['class'] = 'illustration'
          pic_intro['src'] = "https://upload.wikimedia.org/wikipedia/en/thumb/1/1c/Rftg_cover.jpg/220px-Rftg_cover.jpg"

          doc.h2 'Description', :class => 'subheader'
          doc.p 'In Race for the galaxy, players build galactic civilizations using game cards that represents worlds or technical and social developments.'

          doc.h2 'Rules', :class => 'subheader'
          doc.p 'Race for the galaxy is game released by Rio Grande Game. Rules can be found here:'
          rules = doc.a {
            pic_rules = doc.img
            pic_rules['class'] = 'illustration'
            pic_rules['src'] = "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTVTQOAYN62vuwfsyZI7hogTU3-bJtNYSqTpzm9MeuRGlAPXS7rRmoxyw"
          }
          rules['href'] = "http://riograndegames.com/uploads/Game/Game_240_gameRules.pdf"

          doc.h2 "Let's play", :class => 'subheader'
          doc.p 'Please enter the number of players for this game.'

          form_number = doc.form {
            number_players = doc.input
              number_players['type'] = 'text'
              number_players['name'] = 'players_number'
            doc.p ''
            confirm_number = doc.input
              confirm_number['class'] = 'confirm'
              confirm_number['type'] = 'submit'
              confirm_number['value'] = 'Confirm number of players'
          }
          #form_number['action'] = 

        }
      }
    end
    welcome.to_html
  end
end

File.write("test.html", Welcome.display)
