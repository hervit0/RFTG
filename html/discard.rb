require 'nokogiri'
require_relative '../player.rb'
require_relative 'setting.rb'
require_relative 'pictures.rb'

class Discard
  def self.begin_discard
    begin_discard = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc, title: "RFTG - Discard cards")
        end

        doc.body :role => 'document' do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            doc.div :class => "jumbotron" do
              doc.h1 "Draw cards"
              doc.p "Each player is about to draw 6 cards and discard 2 among them. Choose wisely and don't forget that your money is also your hand !"
              doc.p "Good luck warrior !"
            end

            doc.form :action => "/present_player", :method => "POST" do
              doc.input :class => "confirm", :type => "submit", :value => "Understood, let's go !"
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

        doc.body :role => 'document 'do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            doc.div :class => "jumbotron" do
              doc.h1 "#{player}'s turn: discard cards"
              doc.p 'Six cards will be drawn.'
            end

            doc.form :action => "/discard", :method => "POST" do
              doc.input :type => "submit", :value => "See my 6 cards"
            end
            Picture.alien(doc)
          end
        end
      end
    end
    [present.to_html]
  end

  def self.discard_cards(action, player)
    discard = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc, title: "RFTG - Discard cards")
        end

        doc.body :role => 'document' do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            doc.div :class => "jumbotron" do
              doc.h1 "#{player}'s turn: discard cards"
              doc.p 'Six cards have been drawn, please discard two:'
            end

            doc.form :action => "/#{action}", :method => "POST" do
              doc.div :class => "col-md-4" do
                6.times.with_index do |_, i|
                  doc.div :class => "panel panel-primary" do
                    doc.div :class => "panel-heading" do
                    doc.div :class => "panel-title" do
                      doc.h3 "Card #{i + 1}"
                    end
                  end
                    doc.div :class => "panel-body" do
                      doc.label :class => "checkbox-inline" do
                        doc.input :type => "checkbox", :name => "checkbox#{i + 1}", :value => "card#{i + 1}"
                        doc.p "Discard card#{i + 1}"
                      end
                    end
                  end
                end

                doc.input :type => "submit", :value => "Confirm discarded cards"
              end
            end
              Picture.alien(doc)
          end
        end
      end
    end
    [discard.to_html]
  end
end
