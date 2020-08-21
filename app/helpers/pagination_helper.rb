module PaginationHelper
  def r_pagination(&block)
    content_tag(:nav, class: "border-t border-gray-200 px-4 flex items-center justify-between sm:px-0", &block)
  end

  def r_nav_links(&block)
    content_tag(:div, class: "hidden md:flex", &block)
  end

  def r_nav_link(link, &block)
    link_to(link, class: "-mt-px border-t-2 border-transparent py-4 px-4 inline-flex items-center text-sm leading-5 font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-400 transition ease-in-out duration-150", &block)
  end

  def r_active_nav_link(link, &block)
    link_to(link, class: "-mt-px border-t-2 border-indigo-500 py-4 px-4 inline-flex items-center text-sm leading-5 font-medium text-indigo-600 focus:outline-none focus:text-indigo-800 focus:border-indigo-700 transition ease-in-out duration-150", &block)
  end

  def r_nav_link_spacer
    content_tag(:span, class: "-mt-px border-t-2 border-transparent py-4 px-4 inline-flex items-center text-sm leading-5 font-medium text-gray-500") do
      "..."
    end
  end

  def r_previous_nav_button(text, link = nil)
    if link.nil?
      link = text
      text = "Previous"
    end

    content_tag(:div, class: "w-0 flex-1 flex") do
      link_to link, class: "-mt-px border-t-2 border-transparent py-4 pr-1 inline-flex items-center text-sm leading-5 font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-400 transition ease-in-out duration-150" do
        concat(
          content_tag(:svg, class: "mr-3 h-5 w-5 text-gray-400", viewBox: "0 0 20 20", fill: "currentColor") do
            tag(:path, "fill-rule" => "evenodd", d: "M7.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l2.293 2.293a1 1 0 010 1.414z", "clip-rule" => "evenodd")
          end
        )
        concat text
      end
    end
  end

  def r_next_nav_button(text, link = nil)
    if link.nil?
      link = text
      text = "Next"
    end

    content_tag(:div, class: "w-0 flex-1 flex justify-end") do
      link_to(link, class: "-mt-px border-t-2 border-transparent py-4 pl-1 inline-flex items-center text-sm leading-5 font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-400 transition ease-in-out duration-150") do
        concat text
        concat(
          content_tag(:svg, class: "ml-3 h-5 w-5 text-gray-400", viewBox: "0 0 20 20", fill: "currentColor") do
            tag(:path, fill_rule: "evenodd", d: "M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-2.293-2.293a1 1 0 010-1.414z", clip_rule: "evenodd")
          end
        )
      end
    end
  end
end
