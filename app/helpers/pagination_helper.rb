module PaginationHelper
  def r_pagination_wrapper(&block)
    content_tag(:nav, role: "navigation", "aria-label" => "pager", class: "border-t border-gray-200 px-4 flex items-center justify-between sm:px-0", &block)
  end

  def r_nav_links(&block)
    content_tag(:div, class: "hidden md:flex", &block)
  end

  def r_nav_link(text, link)
    link_to(text, link, class: "-mt-px border-t-2 border-transparent py-4 px-4 inline-flex items-center text-sm leading-5 font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-400 transition ease-in-out duration-150")
  end

  def r_active_nav_link(text, link)
    link_to(text, link, class: "-mt-px border-t-2 border-indigo-500 py-4 px-4 inline-flex items-center text-sm leading-5 font-medium text-indigo-600 focus:outline-none focus:text-indigo-800 focus:border-indigo-700 transition ease-in-out duration-150")
  end

  def r_nav_link_spacer
    content_tag(:span, class: "-mt-px border-t-2 border-transparent py-4 px-4 inline-flex items-center text-sm leading-5 font-medium text-gray-500") do
      t("views.pagination.truncate").html_safe
    end
  end

  def r_previous_nav_button(text, link = nil)
    if link.nil?
      link = text
      text = "Previous"
    end

    content_tag(:div, class: "w-0 flex-1 flex") do
      if link
        link_to link, class: "-mt-px border-t-2 border-transparent py-4 pr-1 inline-flex items-center text-sm leading-5 font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-400 transition ease-in-out duration-150" do
          concat "&lt; ".html_safe
          concat text
        end
      end
    end
  end

  def r_next_nav_button(text, link = nil)
    if link.nil?
      link = text
      text = "Next"
    end

    content_tag(:div, class: "w-0 flex-1 flex justify-end") do
      if link
        link_to(link, rel: "next", class: "-mt-px border-t-2 border-transparent py-4 pl-1 inline-flex items-center text-sm leading-5 font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-400 transition ease-in-out duration-150") do
          concat text
          concat " &gt;".html_safe
        end
      end
    end
  end
end
