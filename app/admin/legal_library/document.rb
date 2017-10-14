ActiveAdmin.register LegalLibrary::Document do
  menu parent: 'Legal Library', priority: 2, label: 'Documents'

  config.sort_order = 'title asc'
  permit_params :title

  filter :title

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :category_id, label: 'Category',
                                   as: :select,
                                   collection: LegalLibrary::Category.all { |r| [r.title, r.id] },
                                   include_blank: false
      f.input :body
    end

    f.actions
  end
end
