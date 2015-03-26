module PaginateHelper
  def current_page
    params[:page].to_i
  end

  def will_paginate(collection)
    prev_link = link_to 'Previous', "?page=#{current_page - 1}"
    next_link = link_to 'Next', "?page=#{current_page + 1}"
    content_tag(:div, class: 'paginate') do
      if current_page > 0 && current_page < collection[:total_pages]
        content_tag(:ul) do
          content_tag(:li) { prev_link } +
          content_tag(:li) { next_link }
        end
      elsif current_page < 1 && current_page < collection[:total_pages]
        content_tag(:ul) do
          content_tag(:li) { next_link }
        end
      elsif current_page >= collection[:total_pages]
        content_tag(:ul) do 
          content_tag(:li) { prev_link }
        end
      end    
    end
  end
end