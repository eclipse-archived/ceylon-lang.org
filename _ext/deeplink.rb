require 'rexml/document'

module Awestruct
  module Extensions
    # Transformer for generating id attributes on XHTML elements to aid
    # deep linking. The different algorithms for generating the id can be 
    # plugged in, though the defaults work reasonably OK for English language
    # documents.
    class DeepLink
      
      class ElementVisitor
        def visit(node)
          if node.kind_of?(REXML::Element)
            visitElement(node)
          end
        end
      end
      
      # DOM Visitor which records all the id and name attributes already being
      # used in the document
      class IdCollectingVisitor < ElementVisitor
        # After visiting the DOM, this holds all the id and name attributes it 
        # defined
        attr_reader :existing_ids
      
        def initialize()
          @existing_ids = {}
        end
      
        def visitElement(node)
          if node.attributes["id"]
            @existing_ids[node.attributes["id"]] = node
          end
          if node.attributes["name"]
            @existing_ids[node.attributes["name"]] = node
          end
        end
      end # IdCollector
      
      # DOM Visitor which generates ids for elements in the DOM using the 
      # services of a per-tag id generator
      class IdGeneratingVisitor < ElementVisitor
        def initialize(existing_ids, id_generators)
          @existing_ids = existing_ids
          @generated_ids = {}
          @id_generators = id_generators
        end
        
        def visitElement(node)
          if !node.attributes["id"] and 
                !node.attributes["name"] and
                @id_generators.has_key?(node.name)
            id_generator = @id_generators[node.name]
            id = id_generator.generate_id(node)
            if !id.nil?
              ids = [id]
              while @existing_ids.has_key?(id) or 
                    @generated_ids.has_key?(id)
                conflicting_element = @existing_ids[id] || @generated_ids[id]
                id = id_generator.disambiguate(node, ids, conflicting_element)
                if id.nil?
                  break
                end
                ids << id
              end
              if !id.nil?
                node.attributes["id"] = ids.last
                @generated_ids[ids.last] = node
              end
            end
          end
        end
      end # IdGenerator
      
      # Normalizes the given text into lowercase letters and numbers, words 
      # separated by underscores.
      def DeepLink.normalize(text)
        result = text.strip.downcase
        result = result.gsub(/\s+/, "_")
        result = result.gsub(/(\w)-(\w)/, "\\1_\\2") # e.g. foo-style -> foo_style
        result = result.gsub(/(\w)'(\w)/, "\\1\\2") # e.g. don't -> dont
        result = result.gsub(/[\]\!\"\#\$\%\&\'\(\)\*\+\,\.\/:;<=>?@\[\\^`{|}~-]/, "")
      end
      
      def DeepLink.text_content(element)
        # It seems *unbelievable* that REXML doesn't have a method to get the 
        # full text content of an element (rather than just the first text node)
        # So we have this rigmarole
        result = ""
        element.children.each do |child|
          if child.kind_of?(REXML::Element)
            result << DeepLink.text_content(child)
          elsif child.kind_of?(REXML::Text) or child.kind_of?(REXML::CData)
            result << child.value
          end
        end
        result
      end
      
      # Id generator which uses the normalized text content of the element to
      # construct the element's id. This is suited to section headings 
      # (<h1> etc) because the text content of those elements tends to be short
      class ContentIdGenerator
        def generate_id(node)
          DeepLink.normalize(DeepLink.text_content(node))
        end
        
        def disambiguate(node, generated_ids, conflicting_element)
          "#{generated_ids.first}-#{generated_ids.length+1}"
        end
      end
      
      # Id generator which used the normalized first few words of the element's 
      # content to construct the element's id. This is suited to 
      # paragraph elements (<p>) because their content tends to be long.
      class FirstWordsIdGenerator
        # Set the number of words used to construct the id. If, 
        # for a given element, this number of words produces a non-unique id, 
        # then the id for that element may use more words.
        def initialize(num_words = 5)
          @num_words = num_words
        end
        
        def first_words_normalized(node, num_words)
          words = DeepLink.normalize(DeepLink.text_content(node)).split(/_/)
          result = words[0..(num_words-1)].join("_")
          if words.length > num_words
            result += "..."
          end
          result
        end
        
        def generate_id(node)
          first_words_normalized(node, @num_words)
        end
        
        def disambiguate(node, generated_ids, conflicting_element)
          fixed = first_words_normalized(node, 
                    @num_words + generated_ids.length)
          if generated_ids.include?(fixed)
            fixed = nil # give up
          end
          fixed
        end
      end
      
      # Initialise a deeplink transformer instance with the given id generators
      #
      # Parameters:
      # +id_generators+:: A hash keyed on the tag name with values of the id 
      #                   generator to use for that tag
      def initialize(id_generators = nil)
        if id_generators.nil?
          normalized_content = ContentIdGenerator.new
          normalized_first_sentence = FirstWordsIdGenerator.new
          @id_generators = { "h1" => normalized_content,
              "h2" => normalized_content,
              "h3" => normalized_content,
              "h4" => normalized_content,
              "h5" => normalized_content,
              "h6" => normalized_content,
              "p"  => normalized_first_sentence }
        else 
          @id_generators = id_generators
        end
      end
      
      class Formatter < REXML::Formatters::Default
        def write_element( node, output )
          output << "<#{node.expanded_name}"

          node.attributes.to_a.sort_by {|attr| attr.name}.each do |attr|
            output << " "
            attr.write( output )
          end unless node.attributes.empty?
          output << ">"
          
          node.children.each { |child|
            write( child, output )
          }
          
          output << "</#{node.expanded_name}>"
        end
      end
      
      # Transformer entry point
      def transform(site, page, rendered)
        result = rendered
        if page.output_path.end_with?(".html") 
          doc = REXML::Document.new(rendered)
          collector = IdCollectingVisitor.new
          doc.root.each_recursive do |elem|
            collector.visit(elem)
          end
          generator = IdGeneratingVisitor.new(collector.existing_ids, @id_generators)
          doc.root.each_recursive do |elem|
            generator.visit(elem)
          end
          result = ""
          formatter = Formatter.new
          formatter.write(doc, result)
        end
        result
      end
    end
  end
end
