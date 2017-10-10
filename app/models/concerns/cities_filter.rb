module CitiesFilter
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_by(params)
      cities = City.all

      cities = cities.where(region_id: params[:region_id]) if params[:region_id]
      cities = cities.where('name ~* ?', "^#{params[:query]}") if params[:query]

      cities = cities.limit(params[:limit] || 10) unless params[:region_id]

      return cities.order('size DESC')
    end
  end
end
