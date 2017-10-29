ActiveAdmin.register Question do
  menu parent: 'База вопросов', priority: 2, label: 'Вопросы'

  permit_params :title, :text, :user_id, :category_id, :text, :charged, :created_at

  config.sort_order = 'title_asc'

  index do
    selectable_column
    id_column
    column 'Заголовок', :title
    column 'Текст', :text do |question|
      truncate(question.text, length: 30)
    end
    column 'Пользователь', :user_id do |question|
      truncate(question.user.full_name, length: 20)
    end
    column 'Категория', :category_id { |question| question.category.try(:name) }
    column 'Платный', :charged
    column 'Создан', :created_at
    actions
  end

  show do
    attributes_table do
      row ('Заголовок') { |r| r.title }
      row ('Текст') { |r| r.text }
      row ('Пользователь') { |r| r.user }
      row ('Категория') { |r| r.category }
      row ('Платный') { |r| r.charged }
    end
  end

  filter :title
  filter :text
  filter :user
  filter :category
  filter :charged
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title, label: 'Заголовок'
      f.input :text, label: 'Текст'
      f.input :user_id, label: 'Пользователь', as: :select, collection: User.all.map { |u| [u.full_name, u.id] }, include_blank: false
      f.input :category_id, label: 'Категория', as: :select, collection: Category.all.map { |c| [c.name, c.id] }, include_blank: false
      f.input :charged, label: 'Платный', as: :select, include_blank: false
    end
    f.actions
  end
end
