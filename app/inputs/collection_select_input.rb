class CollectionSelectInput < SimpleForm::Inputs::CollectionSelectInput
  def input_html_classes
    super.push('selectize')
  end
end
