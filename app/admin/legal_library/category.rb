ActiveAdmin.register LegalLibrary::Category, as: 'LegalLibraryCategories' do
  config.filters = false
  config.sort_order = 'title asc'
  menu label: 'Правовая Библиотека', priority: 5
  permit_params :title, :parent_category_id

  controller do
    def index
      @collection = LegalLibrary::Category.top.page(params[:page]).per(10)
      index!
    end

    def create
      create! do |format|
        format.html { redirect_to admin_legal_library_categories_path }
      end
    end

    def update
      update! do |format|
        format.html { redirect_to admin_legal_library_categories_path }
      end
    end
  end

  index do
    id_column
    column "Category" do |category|
      render partial: "category", locals: { category: category }
    end
    column "Subcategories" do |category|
      render partial: "subcategories", locals: { category: category }
    end
  end

  show do
    attributes_table do
      row :title
      row ('documents') do
        render partial: "documents", locals: { documents: resource.documents }
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :parent_category_id, label: 'Parent',
                                   as: :select,
                                   collection: LegalLibrary::Category.top { |r| [r.title, r.id] },
                                   include_blank: true,
                                   selected: params[:parent]
    end

    f.actions
  end
end
