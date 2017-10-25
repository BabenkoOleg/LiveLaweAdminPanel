ActiveAdmin.register LegalLibrary::Document do
  menu false

  config.sort_order = 'title asc'
  permit_params :title, :category_id, :free_content, :paid_content

  filter :title

  controller do
    def destroy
      destroy! do |format|
        format.html { redirect_to admin_legal_library_category_path(resource.category) }
      end
    end
  end

  member_action :upload_file, method: :post do
    resource.update(file: params[:file])
    redirect_to admin_legal_library_document_path(resource)
  end

  member_action :delete_file, method: :delete do
    resource.remove_file!
    resource.save
    redirect_to admin_legal_library_document_path(resource)
  end

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  show do
    attributes_table do
      row :title
      row :category
      row ('free_content') { "<div id='document_free_content'>#{resource.free_content}</div>".html_safe }
      row ('paid_content') { "<div id='document_paid_content'>#{resource.paid_content}</div>".html_safe }
      row ('file') do
        render partial: "files", locals: { document: resource }
      end
    end
  end

  form do |f|
    items = get_categories_for_select_input

    f.inputs do
      f.input :title
      f.input :category_id, label: 'Category',
                                   as: :select,
                                   collection: get_categories_for_select_input,
                                   include_blank: false,
                                   selected: params[:category]
      f.input :free_content
      f.input :paid_content
    end

    f.actions do
      f.action(:submit)
      if resource.category.present?
        f.cancel_link(admin_legal_library_category_path(resource.category))
      else
        f.cancel_link(admin_legal_library_categories_path)
      end
    end
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
    if parent
      item[:title] = "-  #{item[:title]}"
      item[:weight] = parent[:weight] + 1
    else
      items.delete(item)
      items.compact!
    end
  end
  items.sort { |x, y| x[:weight] <=> y[:weight] }
       .map { |item| [item[:title], item[:id]] }
end
