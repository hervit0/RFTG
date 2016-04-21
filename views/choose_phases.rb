require 'nokogiri'

class Phases
  def self.display
    phases = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          doc.title 'RFTG - Choose phases'
          doc.link :type => 'text/css', :rel => 'stylesheet', :href => '../css/style.css'
        end

        doc.body do
          doc.h1 'Race for the galaxy', :class => 'header'
          doc.p 'Welcome on Race for the galaxy board game.'

          doc.img :class => 'illustration', :src => "https://upload.wikimedia.org/wikipedia/en/thumb/1/1c/Rftg_cover.jpg/220px-Rftg_cover.jpg"

          doc.h2 'Description', :class => 'subheader'
          doc.p 'In Race for the galaxy, players build galactic civilizations using game cards that represents worlds or technical and social developments.'

          doc.h2 'Rules', :class => 'subheader'
          doc.p 'Race for the galaxy is game released by Rio Grande Game. Rules can be found here:'
          doc.a :href => "http://riograndegames.com/uploads/Game/Game_240_gameRules.pdf"  do
            doc.img :class => 'illustration', :src => "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTVTQOAYN62vuwfsyZI7hogTU3-bJtNYSqTpzm9MeuRGlAPXS7rRmoxyw"
          end

          doc.h2 "Let's play", :class => 'subheader'
          doc.p 'Please enter the number of players for this game.'

          doc.form :action => '/players_names', :method => 'POST' do
            doc.input :type => 'text', :name => 'player_number'
            doc.input :type => 'submit', :class => 'confirm', :value => 'Confirm number of player'
          end
        end
      end
    end
    [phases.to_html]
  end
end
