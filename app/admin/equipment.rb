ActiveAdmin.register Equipment do

  permit_params :name, :max_class, :desc  ,:user_id

  filter :user_id, as: :select, collection: User.all.collect{|user| [user.email, user.id]}
  filter :name
  filter :desc


  #index form
  index  do
    column :id
    column :user_id do |equipment|
      content_tag(:p, equipment.user.email)
    end
    column :name
    column :max_class
    column :desc
    actions
  end

  #edit form

  form do |f|
    f.inputs  "Equipment Details" do
      f.input :user_id, as: :select, collection: User.all.collect{|user| [user.email, user.id]}, value: :user_id
      f.input :name
      f.input :max_class
      f.input :desc
    end
    f.actions
  end
end
