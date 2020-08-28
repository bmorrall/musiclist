module LayoutHelper
  def r_page_wrapper(&block)
    content_tag(:div, class: "p-3", &block)
  end
end
