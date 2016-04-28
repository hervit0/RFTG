require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'
require_relative 'display.rb'

module View
  class Player
    def self.give_name(players_number)
      names = Nokogiri::HTML::Builder.new do |doc|

        doc.html  do
          doc.head  do
            View::Setting.define_head(doc, title: "RFTG - Names of players")
          end

          doc.body View::Setting.body do
            View::Setting.main_navbar(doc)

            doc.div View::Setting.container do
              View::Setting.jumbotron(doc, head: "My name is Bond...", body: "You're about to rule the galaxy, but what's your name again ?")

              View::Setting.title_h2(doc, "Write your name#{players_number > 1 ? "s" : ""}")
              doc.form :action => '/begin_discard', :method => 'POST', :class => "form-horizontal" do
                players_number.times do |x|
                  View::Text.form(doc, label: "Name of player #{x+1}:", placeholder: "Name ?", name: "player_name#{x+1}")
                end
                View::Button.confirm_form(doc, value: "Confirm names of player")
              end
            end
            View::Picture.alien(doc)
          end
        end
      end
      [names.to_html]
    end

    def self.begin_discard(path)
      begin_discard = Nokogiri::HTML::Builder.new do |doc|

        doc.html do
          doc.head do
            View::Setting.define_head(doc, title: "RFTG - Discard cards")
          end

          doc.body View::Setting.body do
            View::Setting.main_navbar(doc)

            doc.div View::Setting.container do
              View::Setting.jumbotron(doc, head: "To draw or not to draw", body: "Each player is about to draw 6 cards and discard 2 among them. Choose wisely and don't forget that your money is also your hand ! Good luck warrior !")

              doc.form :action => path, :method => "POST", :class => "form-horizontal" do
                View::Button.confirm(doc, value: "Understood, let's go !")
              end
              View::Picture.alien(doc)
            end
          end
        end
      end
      [begin_discard.to_html]
    end

    def self.present(path, player)
      present = Nokogiri::HTML::Builder.new do |doc|

        doc.html do
          doc.head do
            View::Setting.define_head(doc, title: "RFTG - Discard cards")
          end

          doc.body View::Setting.body do
            View::Setting.main_navbar(doc)

            doc.div View::Setting.container do
              View::Setting.jumbotron(doc, head: "#{player}, it's your turn !", body: "Six cards will be drawn for you.")

              doc.form :action => path, :method => "POST", :class => "form-horizontal" do
                View::Button.confirm(doc, value: "See my 6 cards")
              end
              View::Picture.alien(doc)
            end
          end
        end
      end
      [present.to_html]
    end

    def self.discard_cards(path, player_name, player_hand )
      discard = Nokogiri::HTML::Builder.new do |doc|

        doc.html do
          doc.head do
            View::Setting.define_head(doc, title: "RFTG - Discard cards")
          end

          doc.body View::Setting.body do
            View::Setting.main_navbar(doc)

            doc.div View::Setting.container do
              View::Setting.jumbotron(doc, head: "#{player_name}, discard 2 cards", body: "Six cards have been drawn, please discard two. The other four will go in your hand.")

              doc.form :action => path, :method => "POST", :class => "form-horizontal" do
                View::Display.hand(doc, player_hand, discard_parameter: "enabled")
                View::Button.confirm(doc, value: "Confirm discarded cards")
              end
              View::Picture.alien(doc)
            end
          end
        end
      end
      [discard.to_html]
    end

    def self.show_kept_cards(path, player_name, player_hand)
      show = Nokogiri::HTML::Builder.new do |doc|

        doc.html do
          doc.head do
            View::Setting.define_head(doc, title: "RFTG - Kept cards")
          end

          doc.body View::Setting.body do
            View::Setting.main_navbar(doc)

            doc.div View::Setting.container do
              View::Setting.jumbotron(doc, head: "#{player_name}'s hand", body: "These cards are the cards that you've decided to keep.")

              doc.form :action => path, :method => "POST", :class => "form-horizontal" do
                View::Display.hand(doc, player_hand, discard_parameter: "disabled")
                View::Button.confirm(doc, value: "OK, next player")
              end
              View::Picture.alien(doc)
            end
          end
        end
      end
      [show.to_html]
    end
  end
end
