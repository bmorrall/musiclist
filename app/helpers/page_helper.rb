module PageHelper
  def r_page_header(&block)
    content_tag(:header, &block)
  end

  # Page Header -> Breadcrumbs

  def r_breadcrumbs(&block)
    content_tag(:div, &block)
  end

  # Page Header -> Breadcrumbs -> Mobile Breadcrumb Nav

  def r_mobile_breadcrumbs_nav(url)
    content_tag(:nav, class: "sm:hidden") do
      link_to(url, class: "flex items-center text-sm leading-5 font-medium text-gray-500 hover:text-gray-700 transition duration-150 ease-in-out") do
        concat (content_tag(:svg, class: "flex-shrink-0 -ml-1 mr-1 h-5 w-5 text-gray-400", viewBox: "0 0 20 20", fill: "currentColor") do
          tag(:path, :"fill-rule" => "evenodd", d: "M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z", :"clip-rule" => "evenodd")
        end)
        concat "Back"
      end
    end
  end

  # Page Header -> Breadcrumbs -> Breadcrumbs Nav

  def r_breadcrumbs_nav(&block)
    content_tag(:nav, class: "hidden sm:flex items-center text-sm leading-5 font-medium", &block)
  end

  # Page Header -> Breadcrumbs -> Breadcrumbs Nav -> Link/Separator

  def r_home_breadcrumbs_link(url)
    link_to(url, class: "text-gray-500 hover:text-gray-700 transition duration-150 ease-in-out") do
      content_tag(:i, nil, class: "fas fa-home")
    end
  end

  def r_breadcrumbs_link(url, &block)
    link_to(url, class: "text-gray-500 hover:text-gray-700 transition duration-150 ease-in-out", &block)
  end

  def r_breadcrumbs_separator
    content_tag(:svg, class: "flex-shrink-0 mx-1 h-5 w-5 text-gray-400", viewBox: "0 0 20 20", fill: "currentColor") do
      tag(:path, :"fill-rule" => "evenodd", d: "M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z", :"clip-rule" => "evenodd")
    end
  end

  # Page Header -> Page Header Body

  def r_page_header_body(&block)
    content_tag(:div, class: "my-2 md:flex md:items-center md:justify-between", &block)
  end

  # Page Header -> Page Header Body -> Page Header Title

  HEADER_TITLE_STYLES = "text-2xl font-semibold leading-7 text-gray-900 sm:text-3xl sm:leading-9 sm:truncate"

  def r_page_header_title(title, subtitle = nil, &block)
    content_tag(:div, class: "pb-1 flex-1 min-w-0") do
      if subtitle.blank?
        concat content_tag(:"h1", title, class: HEADER_TITLE_STYLES)
      else
        concat _r_page_header_title_block(title, subtitle)
      end
      concat content_tag(:div, &block) if block_given?
    end
  end

  def _r_page_header_title_block(title, subtitle)
    content_tag(:div, class: "-ml-2 -mt-2 flex flex-wrap items-baseline") do
      concat content_tag(:"h1", title, class: "ml-2 mt-2 #{HEADER_TITLE_STYLES}")
      concat content_tag(:"p", subtitle, class: "hidden ml-2 mt-1 text-lg leading-5 text-gray-600 truncate sm:block")
    end
  end

  def r_page_header_categories(&block)
    content_tag(:div, class: "mt-1 flex flex-col sm:mt-0 sm:flex-row sm:flex-wrap", &block)
  end

  PAGE_HEADER_CATEGORY_STYLES = "mt-2 flex items-center text-sm leading-5 text-gray-600 sm:mr-6"

  def r_page_header_category_link(text, url, icon)
    link_to url, class: "#{PAGE_HEADER_CATEGORY_STYLES} hover:text-indigo-400 transition duration-150 ease-in-out" do
      concat content_tag(:i, nil, class: "#{icon} mr-2")
      concat text
    end
  end

  def r_page_header_category_tag(text,icon)
    content_tag(:div, class: PAGE_HEADER_CATEGORY_STYLES) do
      concat content_tag(:i, nil, class: "#{icon} mr-2")
      concat text
    end
  end

  # Page Header -> Page Header Body ->  Page Header Actions

  def r_page_header_actions(&block)
    content_tag(:div, class: "mt-4 flex-shrink-0 flex md:mt-0 md:ml-4", &block)
  end

  def r_page_header_action(text, link, link_options = {})
    content_tag(:span, class: "shadow-sm rounded-md") do
      link_to(text, link, link_options.merge(class: "inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 active:text-gray-800 active:bg-gray-50 transition duration-150 ease-in-out"))
    end
  end

  def r_primary_page_header_action(text, link, link_options = {})
    content_tag(:span, class: "ml-3 shadow-sm rounded-md") do
      link_to(text, link, link_options.merge(class: "inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:shadow-outline-indigo focus:border-indigo-700 active:bg-indigo-700 transition duration-150 ease-in-out"))
    end
  end
end
