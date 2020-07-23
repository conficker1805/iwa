module AssetHelper
  def action
    @current_action ||= begin
      class_mappings = { 'create' => 'new', 'update' => 'edit' }
      class_mappings[action_name] || action_name
    end
  end

  def page_wrapper
    "#{controller_name}-#{action}-container"
  end

  def javascript_init
    application_name  = Rails.application.class.module_parent_name
    js_namespace_name = controller.class.to_s.sub(/Controller$/, '')
                                  .underscore.tr('/', '_').camelize(:lower)
    js_function_name = action.camelize

    javascript_tag <<-JS
      #{application_name}.init();
      if(#{application_name}.init#{js_function_name}) {#{application_name}.init#{js_function_name}()}
      if(#{application_name}.#{js_namespace_name}) {
        if(#{application_name}.#{js_namespace_name}.init) { #{application_name}.#{js_namespace_name}.init(); }
        if(#{application_name}.#{js_namespace_name}.init#{js_function_name}) { #{application_name}.#{js_namespace_name}.init#{js_function_name}(); }
      }
    JS
  end

  # def payload(e)
  #   {
  #     message: e.empty? ? t('.success', scope: :flash_message) : '',
  #     errors: e.keys.zip(e.keys.map{|k| e.full_messages_for(k) }).to_h,
  #     klass: e.marshal_dump.first.class.name.tableize.singularize.tr('/', '_')
  #   }.to_json
  # end

  # def render_jsform(obj)
  #   klass = "Trinity.errors.#{controller_path.tr('/', '_')}.init#{action_name.capitalize}"
  #   "#{klass}( #{ payload(obj.errors) } )"
  # end
end
