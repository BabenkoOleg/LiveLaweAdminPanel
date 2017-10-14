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
    items = get_categories_for_select_input

    f.inputs do
      f.input :title
      f.input :category_id, label: 'Category',
                                   as: :select,
                                   collection: get_categories_for_select_input,
                                   include_blank: false
      f.input :body
    end

    f.actions
  end
end

def get_categories_for_select_input
  items = LegalLibrary::Category.all.map do |category|
    {
      title: category.title,
      id: category.id,
      parent: category.parent_category_id
    }
  end
  items.select { |item| item[:parent].nil? }
       .each_with_index { |item, i| item[:weight] = (i + 1) * 1000 }

  items.select { |item| !item[:parent].nil? }
       .each_with_index do |item, i|

    parent = items.find { |parent| parent[:id] == item[:parent] }
    item[:title] = "-  #{item[:title]}"
    item[:weight] = parent[:weight] + 1
  end
  items.sort { |x, y| x[:weight] <=> y[:weight] }
       .map { |item| [item[:title], item[:id]] }
end
