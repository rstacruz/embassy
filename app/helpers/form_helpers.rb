class Main
  module FormHelpers
    def show_errors_for(field)
      field = field.to_sym
      if @errors && @errors[field].any?
        "<span class='error'>#{@errors[field].first}</span>"
      end
    end

    def checkbox(name, value, options={})
      options['checked'] ||= '1'  if value
      attrs = options.map { |k, v| "#{k}=#{v.to_s.inspect}" }.join(' ')

      "<input type='hidden'   value='0' name='#{name}' />" +
      "<input type='checkbox' value='1' name='#{name}' #{attrs} />"
    end

    def field_attr(field)
      klass = Array.new
      klass << field.to_s.downcase
      klass << 'error'  if @errors && @errors[field.to_sym]

      { :class => klass.join(' ') }
    end
  end

  helpers FormHelpers
end

