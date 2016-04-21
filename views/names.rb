require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'

class Names
  attr_reader :players_number
  def initialize(players_number)
    @players_number = players_number
  end

  def give_name
    names = Nokogiri::HTML::Builder.new do |doc|

      doc.html  do
        doc.head  do
          Setting.define_head(doc, title: "RFTG - Names of players")
        end

        doc.body :role => 'document' do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            doc.div :class => "jumbotron" do
              doc.h1 "Names of players"
              doc.p 'Please enter the name of each player.'
            end

            doc.form :action => '/begin_discard', :method => 'POST' do
              doc.div :class => "col-sm-6" do
                @players_number.times do |x|
                  doc.p "Name of player #{x+1}:"
                  doc.input :type => 'text', :class => "form-control", :placeholder => "Name ?", :name => "player_name#{x+1}"
                end
                Button.confirm(doc, value: "Confirm names of player")
              end
              Picture.alien(doc)
            end

          end
        end
      end
    end
    [names.to_html]
  end
end