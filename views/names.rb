require 'nokogiri'
require_relative 'setting.rb'
require_relative 'pictures.rb'
require_relative 'buttons.rb'
require_relative 'text_input.rb'

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

        doc.body Setting.body do
          Setting.main_navbar(doc)

          doc.div :class => "container theme-showcase", :role => "main" do
            Setting.jumbotron(doc, head: "My name is Bond...", body: "You're about to rule the galaxy, but what's your name again ?")

            Setting.title_h2(doc, "What's your name#{@players_number > 1 ? "s" : ""} ?")
            doc.form :action => '/begin_discard', :method => 'POST', :class => "form-horizontal" do
              @players_number.times do |x|
                Text.form(doc, label: "Name of player #{x+1}:", placeholder: "Name ?", name: "player_name#{x+1}")
              end
              Button.confirm_form(doc, value: "Confirm names of player")
            end
          end
            Picture.alien(doc)
        end
      end
    end
    [names.to_html]
  end
end
