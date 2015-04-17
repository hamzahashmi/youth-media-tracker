ActiveAdmin.register Pitch do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :name, :category, :user, :media, :text
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
show do 
	attributes_table do
		row :name do |pitch|
		  best_in_place pitch, :name, :as => :input 
		end
	end
end
index do
  column(:name) { |i| best_in_place i, :name, :type => :input, :path => [:admin, i] } 
  column(:category) { |i| best_in_place i, :category, :type => :select, :path => [:admin, i],
  	:collection => Pitch.categories.map{|category| [category,category]} }
  column(:media) { |i| best_in_place i, :category, :type => :select, :path => [:admin, i],
  	:collection => Pitch.media_types.map{|media_type| [media_type,media_type]} }
  column(:description) { |i| best_in_place i, :description, :type => :input, :path => [:admin, i] } 
  column "Comments", :comment, sortable: :comments_count do |i| 
  	link_to "Comments (#{Pitch.find(i).comments.count})", admin_pitch_comments_path(Pitch.find(i).id) 
  end
  actions
end

sidebar "Pitch Details", only: [:show, :edit] do
    ul do
      li link_to "Comments", admin_pitch_comments_path(pitch)
    end
  end
 controller do
  def scoped_collection
    super.includes :comments 
  end
end

end
