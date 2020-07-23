# This module adapt Fontawesome 5
# No rails gem for Fontawesome 5 now
module FontAwesomeHelper
  extend ActionView::Helpers::OutputSafetyHelper

  def icon(names = 'flag', original_options = {})
    options = original_options.deep_dup
    classes = ['fa-icon']
    classes.concat icon_names(names)
    classes.concat Array(options.delete(:class))
    text = options.delete(:text)
    right_icon = options.delete(:right)
    icon = content_tag(:i, nil, options.merge(:class => classes))
    icon_join(icon, text, right_icon)
  end

  def icon_join(icon, text, reverse_order = false)
    return icon if text.blank?
    elements = [icon, ERB::Util.html_escape(text)]
    elements.reverse! if reverse_order
    safe_join(elements, " ")
  end

  def icon_names(names = [])
    arr = names.to_s.split(/\s+/)
    arr.map { |n| ['far', 'fas', 'fab'].include?(n) ? n : "fa-#{n}" }
  end
end
