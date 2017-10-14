ActiveAdmin.register LegalLibrary::Category, as: 'LegalLibraryCategories' do
  menu parent: 'Legal Library', priority: 1, label: 'Categories'

  config.sort_order = 'title asc'
  permit_params :title

  controller do
    def scoped_collection
      end_of_association_chain.top
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

  filter :title

  index do
    selectable_column
    id_column
    column :title
    column "SubCategories" do |category|
      render partial: "subcategories", locals: { subcategories: category.subcategories }
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
    end

    f.actions
  end
end
