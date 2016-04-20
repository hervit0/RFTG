require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'

class Welcome
  def self.display
    welcome = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc, title: "RFTG - Welcome")
        end

        doc.body :role => 'document' do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            doc.div :class => "jumbotron" do
              doc.h1 'Welcome !'
              doc.p 'Welcome on Race for the galaxy board game.'
            end

            Picture.presentation(doc)
            doc.div :class => "page-header" do
              doc.h2 'Description', :class => 'subheader'
            end
            doc.p 'In Race for the galaxy, players build galactic civilizations using game cards that represents worlds or technical and social developments.'

            doc.div :class => "page-header" do
              doc.h2 'Rules', :class => 'subheader'
            end
            doc.p "Race for the galaxy is game released by Rio Grande Game. Rules can be found here:"
            doc.a :href => "http://riograndegames.com/uploads/Game/Game_240_gameRules.pdf"  do
              Picture.rules(doc)
            end

            doc.div :class => "page-header" do
              doc.h2 "Let's play", :class => 'subheader'
            end
            doc.p 'Please enter the number of players for this game.'

            doc.form :action => '/players_names', :method => 'POST' do
              doc.input :type => 'text', :name => 'player_number' do
                "Max: 4 players"
              end
              doc.input :type => 'submit', :class => 'confirm', :value => 'Confirm number of player'
            end
          end
        end
      end
    end
    [welcome.to_html]
  end
end

