module View
  class Setting
    def self.define_head(doc, title:)
      doc.meta :charset => "utf-8"
      doc.link :rel => "icon", :href => "http://cdn.freefavicon.com/freefavicons/objects/mushroom-cloud-152-211411.png"
      doc.title title
      doc.link :type => 'text/css', :rel => 'stylesheet', :href => 'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css', :integrity => 'sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7', :crossorigin => 'anonymous'
      doc.script :src => "//code.jquery.com/jquery-1.12.0.min.js"
      doc.script :src => "//code.jquery.com/jquery-migrate-1.2.1.min.js"
      doc.script :src => "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js", :integrity => "sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS", :crossorigin => "anonymous"
    end

    def self.body
      {:role => "document", :style => "padding-top:70px"}
    end

    def self.container
      {:class => "container theme-showcase", :role => "main"}
    end

    def self.main_navbar(doc)
      doc.nav :class => "navbar navbar-inverse navbar-fixed-top"  do
        doc.div :class => "container" do
          doc.div :class => "navbar-header" do
            doc.button :type => "button", :class => "navbar-toggle collapsed", 'data-toggle' => "collapse", 'data-target' => "#navbar", 'aria-expanded' => "false", 'aria-controls' => "navbar" do
              doc.span :class => "sr-only" do doc.p "Toggle nav" end
              doc.span :class => "icon-bar"
              doc.span :class => "icon-bar"
              doc.span :class => "icon-bar"
            end
            doc.a :class => "navbar-brand", :href => "#" do doc.p "RACE FOR THE GALAXY" end
          end
          doc.div :id => "navbar", :class =>"navbar-collapse collapse" do
            doc.ul :class => "nav navbar-nav" do
              navbar = {
                "Home" => "/welcome",
                "Rules" => RULES_LINK,
                "About" => "/welcome"
              }
              navbar.each do |key, value|
                doc.li do
                  doc.a key, :href => value, :style => "padding-bottom:5px"
                end
              end
            end
          end
        end
      end
    end

    def self.jumbotron(doc, head:, body:)
      doc.div :class => "jumbotron", :style => "padding-top:5px; padding-bottom:5px" do
        doc.h1 :style => "font-size:40px" do
          doc.text head
        end
        doc.p body
      end
    end

    def self.title_h2(doc, title)
      doc.div :class => "page-header" do
        doc.h2 title
      end
    end
  end
end
