ActiveAdmin.register AdminUser do
  menu parent: 'Пользователи', priority: 2, label: 'Администраторы'

  permit_params :email, :password, :password_confirmation

  config.sort_order = 'id_asc'

  index do
    selectable_column
    id_column
    column 'Почта', :email
    column 'Создан', :created_at
    actions
  end

  show do
    attributes_table do
      row ('Почта') { |r| r.email }
      row ('Создан') { |r| r.created_at }
    end
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :email, label: 'Эл. почта'
      f.input :password, required: false, label: 'Пароль'
      f.input :password_confirmation, required: false, label: 'Подтверждение пароля'
    end
    f.actions
  end
end
