require 'nokogiri'

module Awestruct
  module Extensions
    class DeepLink
      
      class IdCollector
        attr_reader :existing_ids
      
        def initialize()
          @existing_ids = {}
        end
      
        def visit(node)
          if node.element?
            if node.attr("id")
              @existing_ids[node["id"]] = node
            elsif node.attr("name")
              @existing_ids[node["name"]] = node
            end
          end
        end
      end # IdCollector
      
      class IdGenerator
        def initialize(existing_ids)
          @existing_ids = existing_ids
        end
        
        def visit(node)
          if node.element?
            if ["h1", "h2", "h3", "h4", "h5", "h6"].include?(node.node_name) and
                !node["id"] and 
                !node["name"]
              unambig = generated = normalize(node.content)
              ind = 1
              while @existing_ids.has_key?(unambig)
                unambig = "#{generated}-#{ind}"
                ind += 1
              end
              node["id"] = unambig
            end
          end
          node.children.each do |child|
            child.accept(self)
          end
        end
        
        def normalize(text)
          result = text.downcase
          result = result.gsub(/\s+/, "_")
          result = result.gsub(/(\w)'(\w)/, "\\1\\2") # e.g. don't -> dont
          result = result.gsub(/[\]\!\"\#\$\%\&\'\(\)\*\+\,\.\/:;<=>?@\[\\^`{|}~-]/, "")
        end
      end # IdGenerator
      
      def initialize()
      end
      
      def transform(site, page, rendered)
        if page.output_path.end_with?(".html") 
          doc = Nokogiri::XML(rendered)
          collector = IdCollector.new
          doc.accept(collector)
          doc.accept(IdGenerator.new(collector.existing_ids))
          rendered = doc.serialize()
        end
        rendered
      end
    end
  end
end
