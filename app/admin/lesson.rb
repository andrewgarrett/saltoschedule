ActiveAdmin.register Lesson do


  permit_params :title, :user_id,  :instructor, :schedule_repeat, :warm_up, :conditioning, :start_time, :end_time, :events
  #permit_params :title, :instructor, :schedule_repeat, :warm_up, :conditioning, :start_time, :end_time, :events
  filter :user_id, as: :select, collection: User.all.collect{|user| [user.email, user.id]}
  filter :title
  filter :schedule_repeat


  #index form
  index  do
    column :id
    column :user_id do |lesson|
      content_tag(:p, lesson.user.email)
    end
    column :title
    column :instructor
    column :schedule_repeat
    column :warm_up
    column :conditioning
    column :start_time
    column :end_time
    column :events
    actions
  end

  #edit form

  form do |f|
    f.inputs  "Lesson Details" do
      f.input :user_id, as: :select, collection: User.all.collect{|user| [user.email, user.id]}, value: :user_id
      f.input :title
      f.input :instructor
      f.input :warm_up
      f.input :conditioning
      f.input :schedule_repeat
      f.input :start_time
      f.input :end_time
      f.input :events
    end
    f.actions
  end
end
