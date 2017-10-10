ActiveAdmin.register AdminUser do
  menu parent: 'Users', priority: 2, label: 'Administrators'

  permit_params :email, :password, :password_confirmation

  config.sort_order = 'id_asc'

  index do
    selectable_column
    id_column
    column 'Email', :email
    column 'Created', :created_at
    actions
  end

  show do
    attributes_table do
      row ('Email') { |r| r.email }
    end
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :email, label: 'Email'
      f.input :password, required: false, label: 'Password'
      f.input :password_confirmation, required: false, label: 'Password confirmation'
    end
    f.actions
  end
end
