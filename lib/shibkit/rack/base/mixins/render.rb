module Shibkit
  module Rack
    class Base
      module Mixin
        module Render
          
          ## Get static data
          def asset(asset_name)
            
            @assets ||= Hash.new
            
            unless @assets[asset_name]
              
              asset_file_location = "#{::File.dirname(__FILE__)}/../../assets/assets/#{asset_name.to_s}"
              log_debug "Looking for #{asset_name} at #{asset_file_location}"
              
              begin
                @assets[asset_name.to_s]  = IO.read(asset_file_location)
              
              ## Catch missing files. We'll just return nothing. Catch higher up.
              rescue Errno::ENOENT => oops
                
               log_debug "Requested asset cannot be found"
                
                @assets[asset_name.to_s]  = nil
              
              end
              
            end

            return @assets[asset_name]
            
          end
          
          ## Load and prepare HAML views
          def view(view_name)
            
            @views ||= Hash.new
            
            unless @views[view_name]
      
              view_file_location = "#{::File.dirname(__FILE__)}/../../#{component_name}/views/#{view_name.to_s}.haml"
              @views[view_name]  = IO.read(view_file_location)
              
            end

            return @views[view_name]

          end

          ## Display a chooser page
          def render_page(view_name, locals={})

            ## HAML rendering options
            Haml::Template.options[:format] = :html5
            Haml::Template.options[:ugly]   = true if locals[:ugly] == true
            
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