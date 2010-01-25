# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class LamatelThemeExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/lamatel_theme"

  # Please use lamatel_theme/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    AppConfiguration.class_eval do
      preference :stylesheets, :string, :default => 'compiled/screen,lamatel'
      preference :products_per_page, :int, :default => 12
    end
    
    # Add your extension tab to the admin.
    # Requires that you have defined an admin controller:
    # app/controllers/admin/yourextension_controller
    # and that you mapped your admin in config/routes

    #Admin::BaseController.class_eval do
    #  before_filter :add_yourextension_tab
    #
    #  def add_yourextension_tab
    #    # add_extension_admin_tab takes an array containing the same arguments expected
    #    # by the tab helper method:
    #    #   [ :extension_name, { :label => "Your Extension", :route => "/some/non/standard/route" } ]
    #    add_extension_admin_tab [ :yourextension ]
    #  end
    #end

    # make your helper avaliable in all views
    Spree::BaseController.class_eval do
      helper LamatelHelper
    end
  end
end
