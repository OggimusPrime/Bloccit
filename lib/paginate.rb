module Paginate

  def paginate(params)
    per_page = params[:per_page] || 20
    page = params[:page].to_i || 0
    total_records = count
    total_pages = (total_records / per_page).to_i
    total_pages += 1 unless total_records % per_page
      results = limit(per_page).offset(page * 10) 
      {
      results: results,
      total_pages: total_pages
      }
  end
end