When(/^I upload a photo$/) do
  attach_file("photo", File.join(Rails.root, '/public/images/medium/example.png'), :visible => false)
end

Then(/^I should see the photo "(.*)"$/) do
  expect(page).to have_xpath("//img[starts-with(@src, '/public/images/medium/example.png')]")
end
