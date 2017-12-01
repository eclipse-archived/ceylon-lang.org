require 'mypaginator'
require 'extend_string'

module Awestruct
  module Extensions
    class MyTagger

      class TagStat
        attr_accessor :pages
        attr_accessor :group
        attr_accessor :primary_page
        def initialize(tag, pages)
          @tag   = tag
          @pages = pages
        end

        def to_s
          @tag
        end
      end

      def initialize(tagged_items_property, input_path, output_path='tags', pagination_opts={})
        @tagged_items_property = tagged_items_property
        @input_path  = input_path
        @output_path = output_path
        @pagination_opts = pagination_opts
      end

      def execute(site)
        @tags ||= {}
        all = site.send( @tagged_items_property )
        return if ( all.nil? || all.empty? ) 

        all.each do |page|
          tags = page.tags
          if ( tags && ! tags.empty? )
            tags.each do |tag|
              tag = tag.to_s
              @tags[tag] ||= TagStat.new( tag, [] )
              @tags[tag].pages << page
            end
          end
        end

        all.each do |page|
          page.tags = (page.tags||[]).collect{|t| @tags[t.to_s]}
        end

        ordered_tags = @tags.values
        ordered_tags.sort!{|l,r| -(l.pages.size <=> r.pages.size)}
        #ordered_tags = ordered_tags[0,100]
        ordered_tags.sort!{|l,r| l.to_s <=> r.to_s}

        min = 9999
        max = 0

        ordered_tags.each do |tag|
          min = tag.pages.size if ( tag.pages.size < min )
          max = tag.pages.size if ( tag.pages.size > max )
        end

        span = max - min
        
        if span > 0
          slice = span / 6
          if slice == 0
            slice = 1
          end
          ordered_tags.each do |tag|
            adjusted_size = tag.pages.size - min
            scaled_size = adjusted_size / slice
            tag.group = ( tag.pages.size - min ) / slice
          end
        else
          ordered_tags.each do |tag|
            tag.group = 0
          end
        end

        @tags.values.each do |tag|
          output_prefix = File.join( @output_path, sanitize(tag.to_s) )
          options = { :remove_input=>false, :output_prefix=>output_prefix, :split_title=>'Blog tagged ' + tag.to_s, :blog_tag=>tag.to_s, :collection=>tag.pages }.merge( @pagination_opts )
          paginator = Awestruct::Extensions::MyPaginator.new( @tagged_items_property, @input_path, options )
          primary_page = paginator.execute( site )
          tag.primary_page = primary_page
        end

        site.send( "#{@tagged_items_property}_tags=", ordered_tags )
      end
      
      def sanitize(author)
        #replace accents with unaccented version, go lowercase and replace and space with dash
        author.to_s.urlize({:convert_spaces=>true})
      end
    end
  end
end
