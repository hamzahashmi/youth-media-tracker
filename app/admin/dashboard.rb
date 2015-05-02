ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Total Number of Users" do
          User.all.count
        end
      end
      column do
        panel "Number of New Users" do
         User.where(created_at: Time.zone.now.all_week).count
       end
     end
   end

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

      column do
        panel "Top Three Pitches" do
         table_for Pitch.top_voted.first(3) do
            column :name do |pitch|
              link_to pitch.name, [:admin, pitch]
            end
            column "Created By",:user
            column :created_at
            column "Votes",:name do |pitch|
               pitch.get_upvotes.size
            end
            column "",:name do |pitch|
              link_to "Notify to submit final work", mail_user_pitch_path(pitch), method: :put
            end 
          end
       end
     end
     # most recent comments
     





  end
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
    

  panel "New Users" do
    table_for User.order("created_at desc").limit(10) do
      column :name do |user|
        link_to user.name, [:admin, user]
      end
      column :email
      column :created_at
    end
    strong { link_to "View All Users", admin_users_path }
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
