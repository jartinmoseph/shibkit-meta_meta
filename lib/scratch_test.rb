


require './shibkit/meta_meta.rb'

MM=Shibkit::MetaMeta

Shibkit::MetaMeta.config do |c|
  #c.downloads_logger  = STDOUT
  #c.verbose_downloads = true
  c.autoload   = true
  c.can_delete = false
  c.smartcache_expiry = 60*60
  c.smartcache_active = true
  c.purge_xml = true
  #c.logger.level = Logger::DEBUG
  #c.sources_file = "/Users/pete/Desktop/save.yaml"
  c.selected_groups = :spec_set_2
  c.auto_tag = true
  #c.auto_tag = false
end

#puts "Selected groups"
#puts Shibkit::MetaMeta.config.selected_groups

#Shibkit::MetaMeta.delete_all_cached_files!


puts Shibkit::MetaMeta.entities.count.to_s + " ents"

puts Shibkit::MetaMeta['http://ukfederation.org.uk'].to_yaml
puts "+++++++++++++++"
puts Shibkit::MetaMeta['https://shib.manchester.ac.uk/shibboleth'].to_yaml
puts "+++++++++++++++"
puts Shibkit::MetaMeta['http://metadata.ukfederation.org.uk/ukfederation-metadata.xml'].to_yaml

exit


#puts "Tags"

#Shibkit::MetaMeta.sources.each { |s| puts s.url ; puts s.tags.join(', ') ; puts s.groups.join(', ') }

#Shibkit::MetaMeta.tagged_federations



puts Shibkit::MetaMeta.entities.count




puts 

puts Shibkit::MetaMeta.stats.to_yaml

exit

puts
puts "listing tags for all federations"
Shibkit::MetaMeta.federations.each {|f| puts f.uri + " -> " + f.tags.join(', ')}

puts
puts "listing tags for all entities"
Shibkit::MetaMeta.entities.each {|e| puts e.uri + " -> " + e.tags.join(', ')}

#Shibkit::MetaMeta.entities.each {|e| puts e.uri if ((e.idp? and e.idp.geolocation_urls) or (e.sp? and e.sp.geolocation_urls))}
#Shibkit::MetaMeta.save_cache_file "/Users/pete/Desktop/dump.yaml"
#Shibkit::MetaMeta.save_cache_file "/Users/pete/Desktop/dump2.yaml", :yaml
#Shibkit::MetaMeta.save_cache_file  "/Users/pete/Desktop/dump.rbm",  :marshal

#Shibkit::MetaMeta.flush
#Shibkit::MetaMeta.reset

exit

Shibkit::MetaMeta.load_cache_file "/Users/pete/Desktop/dump_no_xml.rbm", :marshal

puts "2"
Shibkit::MetaMeta.entities.each {|e| puts e.uri if e.urn?}
#Shibkit::MetaMeta.entities.each {|e| puts e.parsed_xml}

puts "3"
Shibkit::MetaMeta.entities.each { |e| puts e.uri if e.multi_federated? }

puts "4"
Shibkit::MetaMeta.entities.each { |e| puts e.xml_comment }


exit

Shibkit::MetaMeta.reset 
Shibkit::MetaMeta.load_sources

Shibkit::MetaMeta.process_sources
Shibkit::MetaMeta.entities.each {|e| puts e.inspect}

Shibkit::MetaMeta.purge_xml!
Shibkit::MetaMeta.save_cache_file "/Users/pete/Desktop/dump_no_xml.rbm", :marshal
Shibkit::MetaMeta.load_cache_file "/Users/pete/Desktop/dump_no_xml.rbm", :marshal


exit

Shibkit::MetaMeta.flush
Shibkit::MetaMeta.reset

#Shibkit::MetaMeta.load_cache_file "/Users/pete/Desktop/smart.yaml"

#Shibkit::MetaMeta.save_sources('/Users/pete/Desktop/save.yaml')

puts
puts "Loaded sources:"
Shibkit::MetaMeta.loaded_sources.keys.each {|s| puts s}
puts "==="
puts 


puts "Additional sources:"
Shibkit::MetaMeta.additional_sources.keys.each { |s| puts s }


puts 
puts "Using these combined sources:"
Shibkit::MetaMeta.sources.each { |s| puts s }


puts "Filtering using:"
puts Shibkit::MetaMeta.selected_federation_uris

Shibkit::MetaMeta.entities.each { |e| next unless e.organisation ; puts e.organisation.display_name ; puts e.organisation.url }
#Shibkit::MetaMeta.save_cache_file "/Users/pete/Desktop/dump.yaml"

exit

Shibkit::MetaMeta.config.only_use(['http://ukfederation.org.uk'])
#Shibkit::MetaMeta.config.selected_federation_uris = :all


Shibkit::MetaMeta.load_sources

Shibkit::MetaMeta.process_sources


Shibkit::MetaMeta.entities.each { |e| next unless e.organisation ; puts e.organisation.display_name ; puts e.organisation.url }


puts "Biggest URI competition winner is..."
puts Shibkit::MetaMeta.entities.sort!{|a,b| a.uri.size <=> b.uri.size}.last

exit

puts "Grab a particular entity by URI: is it an IDP? Is it accountable?"
entity = Shibkit::MetaMeta.from_uri('https://shib.manchester.ac.uk/shibboleth')
puts entity.idp.protocols
puts entity.idp.scopes
exit
puts entity.idp?         # => true
puts entity.accountable? # => true
entity.other_federation_uris << 'http://example.org'
puts "Primary: " + entity.primary_federation_uri
puts "Secondary:" + entity.other_federation_uris.join(';')
puts "All: " + entity.federation_uris.join(';')

"Who is on more than one Federation?"
Shibkit::MetaMeta.entities.each do |e|
  
  if e.multi_federated?
    
    puts "#{e.uri} is in #{e.federation_uris.join(', ')}"
    
  end
  
end

Shibkit::MetaMeta.entities.each {|e| puts "OUCH" unless e.primary?  }

puts "There are #{Shibkit::MetaMeta.sps.count} SPs in #{Shibkit::MetaMeta.federations.count} Federations"

exit

#######

Shibkit::MetaMeta.reset

#Shibkit::MetaMeta.sources_file = :real # Normally automatic


Shibkit::MetaMeta.add_source({
    :uri => 'http://ukfederation.org.uk',
    :name => ' UK Access Management Federation For Education And Research EXTRA',
    :display_name => ' UK Access Management Federation',
    :type => 'federation',
    :countries => ['gb'],
    :metadata => 'http://metadata.ukfederation.org.uk/ukfederation-metadata.xml',
    :certificate => 'http://metadata.ukfederation.org.uk/ukfederation.pem',
    :fingerprint => '',
    :refeds_info => 'https://refeds.terena.org/index.php/FederationUkfed',
    :homepage => 'http://www.ukfederation.org.uk',
    :languages => ['en-gb', 'en'],
    :support_email => ' service@ukfederation.org.uk',
    :description => 'A single solution for accessing online resources and services',
})       


puts "Using the source list #{Shibkit::MetaMeta.sources_file}"

puts Shibkit::MetaMeta.config.autoload?

#Shibkit::MetaMeta.load_sources
Shibkit::MetaMeta.load_sources

puts
puts "Loaded sources:"
Shibkit::MetaMeta.loaded_sources.keys.each {|s| puts s}
puts "==="
puts 


puts "Additional sources:"
Shibkit::MetaMeta.additional_sources.keys.each { |s| puts s }


puts 
puts "Using these combined sources:"
Shibkit::MetaMeta.sources.each { |s| puts s }


puts "Filtering using:"
puts Shibkit::MetaMeta.selected_federation_uris




#Shibkit::MetaMeta.sources

#Shibkit::MetaMeta.refresh




#Shibkit::MetaMeta.federations.each {|f| puts f }

#Shibkit::MetaMeta.entities.each { |e| puts e }

#Shibkit::MetaMeta.idps.each { |e| puts e }

#Shibkit::MetaMeta.sps.each { |e| puts e }

#Shibkit::MetaMeta.orgs.each { |e| puts e }

puts "Number of federations:"
puts Shibkit::MetaMeta.federations.size

puts "Number of entities:"
puts Shibkit::MetaMeta.entities.size


Shibkit::MetaMeta.entities.sort!{|a,b| a.uri.size <=> b.uri.size}.each { |e| puts e }

puts "and the winner is..."
puts Shibkit::MetaMeta.entities.sort!{|a,b| a.uri.size <=> b.uri.size}.last


exit

sources = Shibkit::MetaMeta::Source.load(:real)

#sources['urn:mace:incommon'].read.each do |node|
  
 # next unless node.name == "EntityDescriptor"
#  puts node.name
#  puts node.class
  
#end

#exit

sources.each_value { |v| metadata.sources << v }

metadata.sources.each do |source|
  
  source.refresh
  #source.parse
  
end

metadata.refresh

metadata.federations.each do |federation|
  
  puts federation.display_name
  puts federation.read_at
  puts federation.metadata_id
  puts federation.entities.count
  
  #puts federation.entities.to_yaml
  
  federation.entities.each do |e|
  
  puts "----------------------"
  #puts e.entity_uri
  #puts "IDP!" if e.idp?
  #puts "SP!"  if e.sp?
  #puts

  if e.sp?
    puts "SP..."
    puts e.sp.display_name
    puts e.sp.description
    if e.sp.default_service
      puts e.sp.default_service.attributes.inspect
    end
    puts e.sp.protocols.join(';')

    
  end
    
  end
  
end

#metadata.save_cache_file("/Users/pete/Desktop/test_metadata2.yml")
