require 'shibkit/rack/simulator/models/entity_service'

module Shibkit
  module Rack
    class Simulator
      module Model
        class IDPSAMLResponse # *MOCK* Not real! Bodged! Quick and Dirty!  
          
          require 'shibkit/rack/base/mixins/http_utils'
          
          ## Easy access to Shibkit's configuration settings
          extend Shibkit::Configured
          
          include Shibkit::Rack::Base::Mixin::HTTPUtils
          
          attr_accessor :id
          attr_accessor :protocol
          attr_accessor :session_id
          attr_accessor :digest      
          attr_accessor :identity_provider     
          attr_accessor :assertion_id
          attr_accessor :issue_instant
          attr_accessor :audience
          attr_accessor :name_identifier
          attr_accessor :auth_instant
          attr_accessor :auth_method
          attr_accessor :auth_class
          attr_accessor :attributes
          
          ## New object. Takes block
          def initialize(&block) 
            
            @type           = :undefined
            @issue_instant  = Time.new
            @protocol       = "urn:oasis:names:tc:SAML:2.0:protocol"
            @time_expires   = @issue_instant + 60
            @digest         = "NOTIMPLEMENTEDYET"
            @assertion_id   = "NOTIMPLEMENTEDYET"
            @auth_class     = nil
            @auth_method    = ""
            @id             = DataTools.xsid
        
            ## Execute block if passed one      
            self.instance_eval(&block) if block

          end
          
        end
      end
    end
  end
end