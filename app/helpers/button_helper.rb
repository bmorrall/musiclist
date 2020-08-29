module ButtonHelper
  COMMON_STYLES = "mb-2 md:mb-0 font-semibold border rounded shadow focus:outline-none focus:shadow-outline"

  DISABLED_BUTTON_STYLES = "bg-white text-gray-400 border-gray-400 hover:bg-gray-200"
  GREEN_BUTTON_STYLES = "bg-green-800 text-white border-green-800 hover:bg-green-700"
  ORANGE_BUTTON_STYLES = "bg-orange-400 text-white border-orange-400 hover:bg-orange-500"
  RED_BUTTON_STYLES = "bg-red-600 text-white border-red-700 hover:bg-red-700"

  SIDEBAR_BUTTON_STYLES = "block text-lg py-1 px-2"
  LARGE_BUTTON_STYLES = "#{SIDEBAR_BUTTON_STYLES} md:inline-block"
  SMALL_BUTTON_STYLES = "inline-block text-sm py-0 px-2"

  def large_disabled_button(text, icon, link_args = {})
    button_with_icon(text, icon, [LARGE_BUTTON_STYLES, DISABLED_BUTTON_STYLES], link_args)
  end

  def large_green_button(text, icon, link_args = {})
    button_with_icon(text, icon, [LARGE_BUTTON_STYLES, GREEN_BUTTON_STYLES], link_args)
  end

  def large_orange_button(text, icon, link_args = {})
    button_with_icon(text, icon, [LARGE_BUTTON_STYLES, ORANGE_BUTTON_STYLES], link_args)
  end

  def wide_red_link(text, url, icon, link_args = {})
    link_with_icon(text, url, icon, [SIDEBAR_BUTTON_STYLES, RED_BUTTON_STYLES], link_args)
  end

  def small_disabled_button(text, icon, link_args = {})
    button_with_icon(text, icon, [SMALL_BUTTON_STYLES, DISABLED_BUTTON_STYLES], link_args)
  end

  def small_green_button(text, icon, link_args = {})
    button_with_icon(text, icon, [SMALL_BUTTON_STYLES, GREEN_BUTTON_STYLES], link_args)
  end

  def small_orange_button(text, icon, link_args = {})
    button_with_icon(text, icon, [SMALL_BUTTON_STYLES, ORANGE_BUTTON_STYLES], link_args)
  end

  private

  def button_with_icon(text, icon, styles, link_args = {})
    content_tag(:button, link_args.merge(class: [COMMON_STYLES, *styles].join(" "))) do
      concat content_tag(:i, "", class: "#{icon} mr-2")
      concat text
    end
  end

  def link_with_icon(text, url, icon, styles, link_args = {})
    link_to(url, link_args.merge(class: [COMMON_STYLES, *styles].join(" "))) do
      concat content_tag(:i, "", class: "#{icon} mr-2")
      concat text
    end
  end
end
