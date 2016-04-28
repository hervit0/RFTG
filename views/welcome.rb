require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'
require_relative 'text_input.rb'

module View
  class Welcome
    def self.display(path)
      welcome = Nokogiri::HTML::Builder.new do |doc|

        doc.html do
          doc.head do
            View::Setting.define_head(doc, title: "RFTG - Welcome")
          end

          doc.body View::Setting.body  do
            View::Setting.main_navbar(doc)

            doc.div View::Setting.container do
              View::Setting.jumbotron(doc, head: "Welcome !", body: "Welcome on Race for the galaxy board game. Ready to conquer the galaxy ?")

              View::Setting.title_h2(doc, "Description")
              doc.p 'In Race for the galaxy, players build galactic civilizations using game cards that represents worlds or technical and social developments.'
              View::Picture.presentation(doc)

              View::Setting.title_h2(doc, "Rules")
              doc.p "Race for the galaxy is game released by Rio Grande Game. Rules can be found here:"
              doc.a :href => "http://riograndegames.com/uploads/Game/Game_240_gameRules.pdf"  do
                View::Picture.rules(doc)
              end

              View::Setting.title_h2(doc, "Let's play")
              doc.p 'Please enter the number of players for this game.'

              doc.form :action => path, :method => 'POST', :class => "form-horizontal" do
                Text.form(doc, label: "Number of player", placeholder: "4 players max.", name: "player_number")
                View::Button.confirm_form(doc, value: "Confirm number of player")
              end
            end
          end
        end
      end
      [welcome.to_html]
    end
  end
end
