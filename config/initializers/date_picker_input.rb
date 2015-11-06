class DatePickerInput < SimpleForm::Inputs::StringInput
  def input
    template.content_tag(:div, class: 'input-group date') do
      template.concat @builder.datetime_field(attribute_name, input_html_options)
      template.concat span_calendar
    end
  end
  private
  def input_html_options
    if options.key? :value
      value = options[:value]
    elsif object.respond_to?(attribute_name)
      value = object.send(attribute_name)
    else
      value = ''
    end
    value = Time.zone.parse(value) if value.is_a?(String)
    value = value.strftime("%Y-%m-%d") if value.respond_to?(:strftime)
    { class: 'form-control', readonly: false, value: value.presence || '' }
  end
  def span_calendar
    template.content_tag(:label, class: 'input-group-addon') do
      template.concat icon_calendar
    end
  end
  def icon_calendar
    '<i class="glyphicon glyphicon-calendar primary-font"></i>'.html_safe
  end
end
