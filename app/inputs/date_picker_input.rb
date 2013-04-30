class DatePickerInput < SimpleForm::Inputs::StringInput
  def input_html_classes
    super.push('datepicker')
  end

  def input
    @builder.text_field(attribute_name, input_html_options.merge(date_picker_value(object, attribute_name)))
  end

  def date_picker_value(object, attribute_name)
    return {} if object.nil? || object.try(attribute_name).nil?
    {value: I18n.localize(object.send(attribute_name))}
  end
end
