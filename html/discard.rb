require 'nokogiri'
require_relative '../player.rb'
require_relative 'setting.rb'
require_relative 'pictures.rb'

class Discard
  attr_reader :action
  def initialize(action)
    @action = action
  end

  def discard_cards(player)
    discard = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc)
        end

        doc.body :role => 'document' do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            doc.div :class => "jumbotron" do
              doc.h1 "#{player}'s turn: discard cards", :class => 'header'
              doc.p 'Six cards have been drawn, please discard two:'
            end

            doc.div :class => "packed_cards" do
              6.times do |_|
                doc.img :class => "img-thumbnail", :src => 'http://jolabistouille.j.o.pic.centerblog.net/45777f7a.png'
              end

              doc.form :action => "/#{@action}", :method => "POST" do
                doc.input :class => "confirm", :type => "submit", :value => "Confirm discarded cards"
              end
            end
            Picture.alien(doc)
          end
        end
      end
    end
    [discard.to_html]
  end

  def present_players(player)
    present = Nokogiri::HTML::Builder.new do |doc|

      doc.html do
        doc.head do
          Setting.define_head(doc)
        end

        doc.body :role => 'document 'do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            doc.div :class => "jumbotron" do
              doc.h1 "#{player}'s turn: discard cards", :class => 'header'
              doc.p 'Six cards will be drawn.'
            end

            doc.form :action => "/#{@action}", :method => "POST" do
              doc.input :class => "confirm", :type => "submit", :value => "Confirm to see cards"
            end
          end

            Picture.alien(doc)
        end
      end
    end
    [present.to_html]
  end
end
