require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
 rows = page.all( "#pitch-item").collect {|e| e.find('#pitch-link').text}
 expect(rows.index(e1) < rows.index(e2)).to be true
end

When /I click vote up on "(.*)"/ do |name|
	pitch = Pitch.find_by_name(name)
	link_id = "vote-up" << pitch.id.to_s
	click_link_or_button link_id
end