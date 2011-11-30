module Awestruct
  module Extensions
    class MainAtomizer
      def initialize(entries_name, output_path, opts={})
        @entries_name = entries_name
        @output_path = output_path
        @num_entries = opts[:num_entries] || 50
      end

      def execute(site)
        entries = site.send( @entries_name ) || []
        unless ( @num_entries == :all )
          entries = entries[0, @num_entries]
        end

        atom_pages = []

        entries.each do |entry|
          feed_entry = site.engine.load_page(entry.source_path, :relative_path => entry.relative_source_path, :html_entities => false)

          feed_entry.output_path = entry.output_path
          feed_entry.date = feed_entry.timestamp.nil? ? entry.date : feed_entry.timestamp

          atom_pages << feed_entry
        end

        site.engine.set_urls(atom_pages)

        input_page = File.join( File.dirname(__FILE__), 'main_template.atom.haml' )
        page = site.engine.load_page( input_page )
        page.date = page.timestamp unless page.timestamp.nil?
        page.output_path = @output_path
        page.entries = atom_pages
        page.title = "Ceylon team blog"
        site.pages << page
      end
    end
  end
end
