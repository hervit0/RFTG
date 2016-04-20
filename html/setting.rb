class Setting
  def self.define_head(doc)
    doc.meta :charset => "utf-8"
    doc.link :rel => "icon", :href => "http://getbootstrap.com/favicon.ico"
    doc.title 'RFTG - Welcome'
    doc.link :type => 'text/css', :rel => 'stylesheet', :href => 'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css', :integrity => 'sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7', :crossorigin => 'anonymous'
    doc.script :src => "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js", :integrity => "sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS", :crossorigin => "anonymous"
  end

  def self.main_navbar(doc)
    doc.nav :class => "navbar navbar-inverse navbar-fixed-top" do
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
            doc.li :class => "active" do 
              doc.a :href => "#" do doc.p "Home" end
            end
            doc.li :class => "active" do 
              doc.a :href => "#" do doc.p "Rules" end
            end
            doc.li :class => "active" do 
              doc.a :href => "#" do doc.p "About" end
            end
          end
        end
      end
    end
  end
end
