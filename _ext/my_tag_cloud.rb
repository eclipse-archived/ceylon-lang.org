
module Awestruct
  module Extensions
    class MyTagCloud

      def initialize(items_property, output_path='tags', opts={})
        @items_property = items_property
        @output_path = output_path
        @layout = opts[:layout].to_s
        @title  = opts[:title] || 'Tags'
        @suffix = opts[:items_property_suffix] || 'tags'
      end

      def execute(site)
        page = site.engine.load_page( File.join( File.dirname( __FILE__ ), 'tag_cloud.html.haml' ) )
        page.output_path = File.join( @output_path )
        page.layout = @layout
        page.title  = @title
        page.tags = site.send( "#{@items_property}_#{@suffix}" ) || []
        site.pages << page
        site.send( "#{@items_property}_#{@suffix}_cloud=", LazyPage.new( page ) )
      end
    end

    class LazyPage
      def initialize(page)
        @page = page
      end
      def to_s
        @page.content
      end
    end
  end
end
