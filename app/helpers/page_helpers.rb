class Main
  module PageHelpers
    def body_class(v = nil)
      @body_classes ||= []
      @body_classes << v  if v

      @body_classes.join(' ')
    end

    def title(title=nil)
      @page_title = title  if title
      @page_title
    end

    def content_for?(what)
      ! yield_content(what).to_s.empty?
    end

    def haml_popup(template, options={}, locals={})
      if request.xhr?
        haml template, layout: :'layouts/popup'
      else
        haml template, options, locals
      end
    end
  end

  helpers PageHelpers
end
