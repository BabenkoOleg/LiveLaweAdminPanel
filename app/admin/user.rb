ActiveAdmin.register User do
  menu parent: 'Пользователи', priority: 3, label: 'Пользователи'

  permit_params :email, :password, :password_confirmation, :first_name,
                :last_name, :middle_name, :email_public, :phone, :experience,
                :qualification, :price, :university, :faculty,
                :date_of_graduation, :work, :staff, :dob, :avatar, :login, :fax,
                :userdata, :extends

  config.sort_order = 'id_asc'

  index do
    selectable_column
    id_column
    column 'Эл. почта', :email
    column 'Ф. И. О.', :full_name
    column 'Роль', :role
    column 'Телефон', :phone
    column 'Должность', :staff
    column 'Квалификация', :qualification
    column 'Опыт', :experience
    column 'Стоимость услуг', :price
    actions
  end

  filter :email
  filter :created_at

  show do
    attributes_table do
      row ('Эл. почта') { |r| r.email }
      row ('Имя') { |r| r.first_name }
      row ('Фамилия') { |r| r.last_name }
      row ('Отчество') { |r| r.middle_name }
      row ('Роль')  { |r| r.role }
      row ('Публиковать эл. почту') { |r| r.email_public }
      row ('Телефон') { |r| r.phone }
      row ('Опыт') { |r| r.experience }
      row ('Квалификация') { |r| r.qualification }
      row ('Стоимость услуг') { |r| r.price }
      row ('Название ВУЗа') { |r| r.university }
      row ('Факультет') { |r| r.faculty }
      row ('Дата выпуска') { |r| r.date_of_graduation }
      row ('Место работы') { |r| r.work }
      row ('Должность') { |r| r.staff }
      row ('Дата рождения') { |r| r.dob }
      row ('Аватар') { |r| r.avatar }
      row ('Логин') { |r| r.login }
      row ('Факс') { |r| r.fax }
    end
  end

  controller do
    def update_resource(object, attributes)
      update_method =
        attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

  form do |f|
    f.inputs do
      f.input :email, label: 'Эл. почта'
      f.input :password, label: 'Пароль'
      f.input :password_confirmation, label: 'Подтверждение пароля'
      f.input :first_name, label: 'Имя'
      f.input :last_name, label: 'Фамилия'
      f.input :middle_name, label: 'Отчество'
      f.input :role, label: 'Роль', include_blank: false
      f.input :email_public, label: 'Публиковать эл. почту'
      f.input :phone, label: 'Телефон'
      f.input :experience, label: 'Опыт'
      f.input :qualification, label: 'Квалификация'
      f.input :price, label: 'Стоимость услуг'
      f.input :university, label: 'Название ВУЗа'
      f.input :faculty, label: 'Факультет'
      f.input :date_of_graduation, label: 'Дата выпуска', as: :datepicker
      f.input :work, label: 'Место работы'
      f.input :staff, label: 'Должность'
      f.input :dob, label: 'Дата рождения', as: :datepicker
      f.input :avatar, label: 'Аватар'
      f.input :login, label: 'Логин'
      f.input :fax, label: 'Факс'
    end
    f.actions
  end
end
