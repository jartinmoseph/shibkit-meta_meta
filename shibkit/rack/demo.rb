##
##

module Shibkit
  
  module Rack
  
    class Demo < Shibkit::Rack::Base
      
      ## Require various mixins too
      require 'shibkit/rack/demo/mixins/actions'
      
      include Shibkit::Rack::Demo::Mixin::Actions
      
      ## Middleware application components and behaviour
      CONTENT_TYPE   = { "Content-Type" => "text/html; charset=utf-8" }
      START_TIME     = Time.new
      
      ## Setup
      def initialize(app)
      
        ## Rack app
        @app = app
        
      end
      
      ## Selecting an action and returning to the Rack stack 
      def call(env)
      
        ## Peek at user input, they might be talking to us
        request = ::Rack::Request.new(env)
        
        begin

          ## Route to actions according to requested URLs
          case request.path
          
          ## Is the demo being requested?
          when regexify(demo_path)
            
            ## Serve up a suitable page based on content protection being used
            #return config.content_protection == :active ?
            #  actively_protected_demo_page_action :
            #  passively_protected_demo_page_action
            
            return demo_page_action(env, nil, options={})
            
          else
            
            ## Onwards and upwards: pass control through to next middleware in rack
            return @app.call(env)
            
          end
        
        ## Catch any errors generated by this middleware class. Do not catch other Middleware errors.
        rescue Shibkit::Rack::Demo::RuntimeError => oops

          ## Render a halt page
          return fatal_error_action(env, oops)

        end
        
      end

      private
      
      def demo_path
        
        glue_paths(config.demo_path)
        
      end
      
    end    
  end
end