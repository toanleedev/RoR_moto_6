module StaticPagesHelper
  def province_search_options
    Address.all.distinct.pluck(:province)
  end
end
