ActiveAdmin.register LegalLibrary::Category, as: 'LegalLibrarySubcategories' do
  menu false

  config.sort_order = 'title asc'
  permit_params :title, :parent_category_id

  controller do
    def scoped_collection
      end_of_association_chain.nested
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

    def destroy
      destroy! do |format|
        format.html { redirect_to admin_legal_library_categories_path }
      end
    end
  end

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :parent_category_id, label: 'Parent',
                                   as: :select,
                                   collection: LegalLibrary::Category.top { |r| [r.title, r.id] },
                                   include_blank: false
    end

    f.actions do
      f.action(:submit)
      f.cancel_link(admin_legal_library_categories_path)
    end
  end
end
