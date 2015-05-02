# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the (YouthZone Del Norte )?home\s?page$/ then '/'
    when /^the sign_up page$/ then signup_path
    when /^the login page$/ then login_path
    when /^the edit page$/ then edit_user_registration_path
    when /^the pitch new page$/ then new_pitch_path
    when /^the pitch edit page$/ then edit_pitch_path
    when /^users page$/ then users_path
    when /^the about page$/ then about_path
    when /^the admin page$/ then admin_root_path
    when /^the final work page$/ then media_path
    when /^the scheduling options page$/ then admin_scheduling_path

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
