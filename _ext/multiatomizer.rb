module Awestruct
  module Extensions
    class MultiAtomizer
      def initialize(entries_name, filtered_property, output_path, output_file='blog.atom',opts={})
        @entries_name = entries_name
        @output_path = output_path
        @output_file = output_file
        @num_entries = opts[:num_entries] || 50
        @filtered_property = filtered_property
      end

      def execute(site)
        entries = site.send( @entries_name ) || []
        names = []
        atom_pages_per_name = {}
        entries.each do |entry|
          name = entry.send( @filtered_property )
          unless ( names.include?(name) )
            names << name
            atom_pages_per_name[name] = []
          end
          atom_pages = atom_pages_per_name[name]
          if ( @num_entries == :all || atom_pages.length < @num_entries )
            feed_entry = site.engine.load_page(entry.source_path, :relative_path => entry.relative_source_path, :html_entities => false)
            feed_entry.output_path = entry.output_path
            feed_entry.date = feed_entry.timestamp.nil? ? entry.date : feed_entry.timestamp
            atom_pages << feed_entry
          end
        end
        
        names.each do |name|
          atom_pages = atom_pages_per_name[name]
          createAtomPage(name,atom_pages_per_name,site)
        end
      end
      
      def createAtomPage(name,atom_pages_per_name,site)
        atom_pages = atom_pages_per_name[name]
        site.engine.set_urls(atom_pages)

        input_page = File.join( File.dirname(__FILE__), 'template.atom.haml' )
        page = site.engine.load_page( input_page )
        page.date = page.timestamp unless page.timestamp.nil?
        page.output_path = @output_path + "/" + name.to_s + "/" + @output_file
        page.entries = atom_pages
        page.title = site.title || site.base_url
        site.pages << page
      end
    end
  end
end
