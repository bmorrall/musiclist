module TableHelper
  def r_table(collection = nil, &block)
    r_table_wrapper do
      concat r_table_tag(&block)
      concat paginate(collection, param_name: :page) if collection
    end
  end

  def r_table_wrapper(&block)
    content_tag(:div, class: "flex flex-col overflow-x-hidden") do
      content_tag(:div, class: "-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8") do
        content_tag(:div, class: "py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8") do
          content_tag(:div, class: "shadow overflow-hidden border-b border-gray-200 sm:rounded-lg", &block)
        end
      end
    end
  end

  def r_table_tag(&block)
    content_tag(:table, class: "lg:table-fixed min-w-full divide-y divide-gray-200", &block)
  end

  # Table -> Header

  def r_table_header_row(&block)
    content_tag(:tr, &block)
  end

  def r_primary_table_header_cell(&block)
    content_tag(:th, class: "lg:w-1/4 px-6 py-3 bg-gray-100 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider", &block)
  end

  def r_table_header_cell(&block)
    content_tag(:th, class: "hidden md:table-cell px-6 py-3 bg-gray-100 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider", &block)
  end

  def r_actions_table_header_cell
    content_tag(:th, nil, class: "px-6 py-3 bg-gray-100")
  end

  # Table -> Body

  def r_table_row(index, highlight: false, &block)
    # index starts at 0, we want to start with an odd row
    if index.even?
      r_odd_table_row(highlight: highlight, &block)
    else
      r_even_table_row(highlight: highlight, &block)
    end
  end

  def r_even_table_row(highlight: false, &block)
    content_tag(:tr, class: highlight ? "bg-blue-200" : "bg-gray-100", &block)
  end

  def r_odd_table_row(highlight: false, &block)
    content_tag(:tr, class: highlight ? "bg-blue-300" : "bg-white", &block)
  end

  def r_primary_table_cell(link, link_options = {}, &block)
    content_tag(:td, class: "px-6 py-4 whitespace-no-wrap text-sm leading-5 font-medium text-gray-900") do
      link_to(link, link_options.merge(class: "hover:text-gray-600"), &block)
    end
  end

  def r_table_cell(&block)
    content_tag(:td, class: "hidden md:table-cell px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-600", &block)
  end

  def r_actions_table_cell(&block)
    content_tag(:td, class: "px-6 py-4 whitespace-no-wrap text-right text-sm leading-5 font-medium", &block)
  end

  # Table -> Body -> Action

  def r_table_cell_action(label, link, link_options = {})
    link_to(label, link, link_options.merge(class: "text-indigo-600 hover:text-indigo-900"))
  end
end
