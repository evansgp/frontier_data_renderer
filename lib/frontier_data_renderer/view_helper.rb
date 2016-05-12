module FrontierDataRenderer::ViewHelper

 def render_data(value, type=:string, opts={})
    if value.present?
      format_value(value, type, opts)
    else
      no_data_message(type)
    end
  end

private

  def format_value(value, type, opts)
    case type.to_sym
    when :boolean
      value ? "Yes" : no_data_message(:boolean)
    when :currency
      number_to_currency(value, opts)
    when :datetime
      time_tag(value.to_datetime, opts.reverse_merge(format: :default))
    when :date
      time_tag(value.to_date, opts.reverse_merge(format: :default))
    when :percentage
      number_to_percentage(value, opts.reverse_merge(precision: 0))
    when :text
      if opts[:length].present?
        content_tag(:span, truncate(value, opts), title: value)
      else
        value
      end
    else
      value
    end
  end

  def no_data_message(type)
    if type == :boolean
      content_tag(:span, "No", class: FrontierDataRenderer.no_data_class)
    else
      content_tag(:abbr, "N/A", class: FrontierDataRenderer.no_data_class, title: "Not available")
    end
  end

end
