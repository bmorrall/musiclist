module LayoutHelper
  HEADER_CLASS = "text-4xl leading-tight"

  def r_page_wrapper(&block)
    content_tag(:div, class: "p-0 md:p-3", &block)
  end

  def r_page_header(text=nil, &block)
    if block_given?
      content_tag(:h1, class: HEADER_CLASS, &block)
    else
      content_tag(:h1, text, class: HEADER_CLASS)
    end
  end
end
