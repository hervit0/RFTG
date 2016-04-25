require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'

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

  def self.discard_cards(player)
    discard = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc, title: "RFTG - Discard cards")
        end

        doc.body Setting.body do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            Setting.jumbotron(doc, head: "#{player}, discard 2 cards", body: "Six cards have been drawn, please discard two. The other four will go in your hand.")

            doc.form :action => "/show_kept_cards", :method => "POST", :class => "form-horizontal" do
              doc.div :class => "col-sd-2" do
                6.times.with_index do |_, i|
                  doc.div :class => "panel panel-primary" do
                    doc.div :class => "panel-heading" do
                    doc.div :class => "panel-title" do
                      doc.h3 "Card #{i + 1}", :style => "margin-top:0px; margin-bottom:0px"
                    end
                  end
                    doc.div :class => "panel-body" do
                      doc.label :class => "checkbox-inline" do
                        doc.input :type => "checkbox", :name => "checkbox#{i + 1}", :value => "#{i + 1}"
                        doc.p "Discard card #{i + 1}"
                      end
                    end
                  end
                end

                Button.confirm(doc, value: "Confirm discarded cards")
              end
            end
              Picture.alien(doc)
          end
        end
      end
    end
    [discard.to_html]
  end

  def self.show_kept_cards(action, player)
    show = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc, title: "RFTG - Kept cards")
        end

        doc.body Setting.body do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            Setting.jumbotron(doc, head: "#{player}, ", body: "These cards are the cards that you've kept")

            doc.form :action => "/#{action}", :method => "POST", :class => "form-horizontal" do
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
