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
  permit_params :email, :password, :password_confirmation ,:is_active

  index do
    column :email
    column :is_active,:as => :select ,collection: [["Yes", true], ["No", false]]
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :email
     f.input :password
     f.input :password_confirmation
      f.input :is_active ,:as => :select ,collection: [["Yes", true], ["No", false]]
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :is_active,:as => :select ,collection: [["Yes", true], ["No", false]]
      row :sign_in_count
      row :current_sign_in_ip
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
