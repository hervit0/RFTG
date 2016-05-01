require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'
require_relative 'text_input.rb'

module View
  class Welcome
    def self.display(path, method)
      welcome = Nokogiri::HTML::Builder.new do |doc|

        doc.html do
          doc.head do
            Setting.define_head(doc, title: "RFTG - Welcome")
          end

          doc.body Setting.body  do
            Setting.main_navbar(doc)

            doc.div Setting.container do
              Setting.jumbotron(doc, head: "Welcome !", body: "Welcome on Race for the galaxy board game. Ready to conquer the galaxy ?")

              Setting.title_h2(doc, "Description")
              doc.p 'In Race for the galaxy, players build galactic civilizations using game cards that represents worlds or technical and social developments.'
              Picture.presentation(doc)

              Setting.title_h2(doc, "Rules")
              doc.p "Race for the galaxy is game released by Rio Grande Game. Rules can be found here:"
              doc.a :href => "http://riograndegames.com/uploads/Game/Game_240_gameRules.pdf"  do
                Picture.rules(doc)
              end

              Setting.title_h2(doc, "Let's play")
              doc.p 'Please enter the number of players for this game.'

              doc.form :action => path, :method => method, :class => "form-horizontal" do
                Text.form(doc, label: "Number of player", placeholder: "4 players max.", name: "player_number")
                Button.confirm_form(doc, value: "Confirm number of player")
              end
            end
          end
        end
      end
      [welcome.to_html]
    end
  end
end
