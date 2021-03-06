class SnippetsExtension < Spree::Extension
  version "0.2"
  description "Admin configurable static content for CMS control over specific sections of a view."
  url "http://github.com/cmaujean/spree-snippets"
  
  # Developer will embed calls to render specific snippet slugs or ids
  # in any view. Admin will control content via /admin/snippets.
  def activate

    Admin::BaseController.class_eval do
      before_filter :add_snippets_tab
    
      def add_snippets_tab
        # add_extension_admin_tab takes an array containing the same arguments expected
        # by the tab helper method:
        #   [ :extension_name, { :label => "Your Extension", :route => "/some/non/standard/route" } ]
        add_extension_admin_tab [ :snippets, { :label => t("Snippets"), :route => :admin_snippets } ]
      end
    end
    
    Spree::BaseController.class_eval do

      helper_method :render_snippet
      
      # snippet can be something that responds to "slug" and "content", 
      # or a slug, or an id
      def render_snippet(snippet)
        if snippet.respond_to?('content')  
          @snippet = snippet
        elsif snippet.kind_of?(Fixnum)
          @snippet = Snippet.find(snippet)
        elsif snippet.kind_of?(String)
          @snippet = Snippet.find_by_slug(snippet)
        else
          raise "Unable to handle snippet '#{snippet}'"
        end 
        raise "Snippet '#{snippet}' not found" if @snippet.nil?
        template = ERB.new File.read(File.expand_path(snippet_wrapper_absolute_path))
        template.result(binding)
      end
      
      private
      # Returns the location of the snippet wrapper, which is dependent on how spree is installed.
      def snippet_wrapper_absolute_path
        [SPREE_ROOT, RAILS_ROOT].each do |root|
          absolute_path = root + snippet_wrapper_path
          return absolute_path if File.exists?(absolute_path)
        end
        raise "Unable to find snippet wrapper using path '#{snippet_wrapper_path}'"        
      end
      # Override the location returned by this method if you want your own snippet wrapper template
      def snippet_wrapper_path
        '/vendor/extensions/snippets/app/views/snippet/_display.html.erb'
      end
    end

  end
end
