ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

   
    # Most recent pitches
    columns do
      column do
        panel "Recent Pitches" do
          table_for Pitch.order("created_at desc").limit(5) do
            column :name do |pitch|
              link_to pitch.name, [:admin, pitch]
          end
          column "Created By",:user
          column :created_at
      end
      strong { link_to "View All Pitches", admin_pitches_path }
  end
end


     # most recent comments
     column do
        panel "Recent Comments" do
          table_for Comment.order("created_at desc").limit(10) do
            column :body do |comment|
              link_to comment.body, [:admin, comment]
          end
          column "Created By",:user
          column :created_at
      end
      strong { link_to "View All Comments", admin_comments_path }
  end
end
end



    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
