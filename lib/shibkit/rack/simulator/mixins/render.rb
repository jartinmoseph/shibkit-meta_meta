module Shibkit
  module Rack
    class Simulator
      module Mixin
        module Render
          
          ## Get static data
          def asset(asset_name)
            
            @assets ||= Hash.new
            
            unless @assets[asset_name]
      
              asset_file_location = "#{::File.dirname(__FILE__)}/../assets/#{asset_name.to_s}"
              @assets[asset_name]  = IO.read(asset_file_location)
              
            end

            return @assets[asset_name]
            
          end
          
          ## Load and prepare HAML views
          def view(view_name)
            
            @views ||= Hash.new
            
            unless @views[view_name]
      
              view_file_location = "#{::File.dirname(__FILE__)}/../views/#{view_name.to_s}.haml"
              @views[view_name]  = IO.read(view_file_location)
              
            end

            return @views[view_name]

          end

          ## Display a chooser page
          def render_page(view_name, locals={})

            ## HAML rendering options
            Haml::Template.options[:format] = :html5
            
            ## Render the content
            content = Haml::Engine.new(view(view_name))
            locals[:content_html] = content.render(Object.new, locals)
            
            ## Pass variables with rendered content into the page & render
            page = Haml::Engine.new(view(locals[:layout] || :layout ))
            
            return page.render(Object.new, locals)
            
          end  

        end
      end
    end
  end
end