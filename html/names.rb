require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'

class Names
  attr_reader :players_number
  def initialize(players_number)
    @players_number = players_number
  end

  def give_name
    names = Nokogiri::HTML::Builder.new do |doc|

      doc.html  do
        doc.head  do
          Setting.define_head(doc)
        end

        doc.body :role => 'document' do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            doc.div :class => "jumbotron" do
              doc.h1 "What's your names ?"
              doc.p 'Please enter the name of each player.'
            end

            doc.form :action => '/discard', :method => 'POST' do
              @players_number.times do |x|
                doc.p "Name of player #{x+1}:"
                doc.input :type => 'text', :name => "player_name#{x+1}"
              end
              doc.input :type => 'submit', :class => 'confirm', :value => 'Confirm number of player'
            end

            Picture.alien(doc)

          end
        end
      end
    end
    [names.to_html]
  end
end
