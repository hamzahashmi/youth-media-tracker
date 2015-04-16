ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
index do
  column(:email) { |i| best_in_place i, :email, :type => :input, :path => [:admin, i] } 
  column(:name) { |i| best_in_place i, :name, :type => :input, :path => [:admin, i] } 
  column(:address_zip_code) { |i| best_in_place i, :address_zip_code, :type => :input, :path => [:admin, i] } 
  column(:bio) { |i| best_in_place i, :bio, :type => :input, :path => [:admin, i] } 
  column(:suspended) { |i| best_in_place i, :suspended, :type => :select, :path => [:admin, i],
  	:collection =>  [["No","No"],["Yes","Yes"]] }

  actions
end

end
