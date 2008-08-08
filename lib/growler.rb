require 'ruby-growl'
class Growler
  def growl msg
    g = Growl.new "localhost", "ruby-growl",
                  ["ruby-growl Notification"]
    g.notify "ruby-growl Notification", ":::: From Rails ::::::::",
             "#{msg}",1,1
  end
end
