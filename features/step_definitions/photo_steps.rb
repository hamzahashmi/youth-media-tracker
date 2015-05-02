When(/^I upload a photo$/) do
  attach_file("user_photo", File.join(Rails.root, 'public', 'images', 'medium', 'example.png'))
end

Then /^I should see the photo "(.+)"$/ do |photo|
       expect(page).to have_xpath("//img[contains(@src, \"#{photo}\")]")
end
