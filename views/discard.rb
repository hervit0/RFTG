require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'
require_relative 'display.rb'

class Discard
  def self.begin_discard
    begin_discard = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc, title: "RFTG - Discard cards")
        end

        doc.body Setting.body do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            Setting.jumbotron(doc, head: "To draw or not to draw", body: "Each player is about to draw 6 cards and discard 2 among them. Choose wisely and don't forget that your money is also your hand ! Good luck warrior !")

            doc.form :action => "/present_player", :method => "POST", :class => "form-horizontal" do
              Button.confirm(doc, value: "Understood, let's go !")
            end
            Picture.alien(doc)
          end
        end
      end
    end
    [begin_discard.to_html]
  end

  def self.present_players(player)
    present = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc, title: "RFTG - Discard cards")
        end

        doc.body Setting.body do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            Setting.jumbotron(doc, head: "#{player}, it's your turn !", body: "Six cards will be drawn for you.")

            doc.form :action => "/discard", :method => "POST", :class => "form-horizontal" do
              Button.confirm(doc, value: "See my 6 cards")
            end
            Picture.alien(doc)
          end
        end
      end
    end
    [present.to_html]
  end

  def self.discard_cards(player_name, player_hand )
    discard = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc, title: "RFTG - Discard cards")
        end

        doc.body Setting.body do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            Setting.jumbotron(doc, head: "#{player_name}, discard 2 cards", body: "Six cards have been drawn, please discard two. The other four will go in your hand.")

            doc.form :action => "/show_kept_cards", :method => "POST", :class => "form-horizontal" do
              Display.hand(doc, player_hand, discard_parameter: "enabled")
              Button.confirm(doc, value: "Confirm discarded cards")
            end
            Picture.alien(doc)
          end
        end
      end
    end
    [discard.to_html]
  end

  def self.show_kept_cards(action, player_name, player_hand)
    show = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc, title: "RFTG - Kept cards")
        end

        doc.body Setting.body do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            Setting.jumbotron(doc, head: "#{player_name}'s hand", body: "These cards are the cards that you've decided to keep.")

            doc.form :action => "/#{action}", :method => "POST", :class => "form-horizontal" do
              Display.hand(doc, player_hand, discard_parameter: "disabled")
              Button.confirm(doc, value: "OK, next player")
            end
            Picture.alien(doc)
          end
        end
      end
    end
    [show.to_html]
  end
end
