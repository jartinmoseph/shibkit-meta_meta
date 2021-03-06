## @author    Pete Birkinshaw (<pete@digitalidentitylabs.com>)
## Copyright: Copyright (c) 2011 Digital Identity Ltd.
## License:   Apache License, Version 2.0

## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
## 
##     http://www.apache.org/licenses/LICENSE-2.0
## 
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##

module Shibkit
  class MetaMeta

    ## 
    class Service < MetadataItem
      
      require 'shibkit/meta_meta/metadata_item'
      
      ## Element and attribute used to select XML for new objects
      ROOT_ELEMENT = 'AttributeConsumingService'
      TARGET_ATTR  = 'index'
      REQUIRED_QUACKS = [:index]
      
      ## 
      attr_accessor :names
      
      ## 
      attr_accessor :descriptions
      
      ## 
      attr_accessor :index
      
      ## 
      attr_accessor :attributes
      
      attr_accessor :default
      
      alias :default? :default
    
      def name(lang=:en)
        
        return names[lang]
        
      end
      
      def description(lang=:en)
        
        return descriptions[lang]
        
      end
    
      def to_s
        
        return name(:en)
        
      end
    
     private
     
     def parse_xml

       @index = @noko['index'].to_i || 0
       
       @default = @noko['isDefault'] || 'false'
       
       ## Display names
       @names = extract_lang_map_of_strings("xmlns:ServiceName")
       
       ## Descriptions
       @descriptions = extract_lang_map_of_strings("xmlns:ServiceDescription")
      
       @attributes ||= Array.new
       @noko.xpath('xmlns:RequestedAttribute').each do |ax|
          
         attribute = Shibkit::MetaMeta::RequestedAttribute.new(ax).filter
          
         @attributes << attribute if attribute
          
       end
       
       log.debug "   Derived service #{name} from XML"
       
    end
        
    end
  end
end