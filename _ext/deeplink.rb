require 'nokogiri'
require 'unicode'


module Awestruct
  module Extensions
    # Transformer for generating id attributes on XHTML elements to aid
    # deep linking. The different algorithms for generating the id can be 
    # plugged in, though the defaults work reasonably OK for English language
    # documents.
    class DeepLink
      
      class ElementVisitor
        def visit(node)
          if node.element?
            visitElement(node)
          end
          node.children.each do |child|
            child.accept(self)
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
          if node["id"]
            @existing_ids[node["id"]] = node
          end
          if node["name"]
            @existing_ids[node["name"]] = node
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
          if !node["id"] and 
                !node["name"] and
                @id_generators.has_key?(node.node_name)
            id_generator = @id_generators[node.node_name]
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
                node["id"] = ids.last
                @generated_ids[ids.last] = node
              end
            end
          end
        end
      end # IdGenerator
      
      # Normalizes the given text into lowercase letters and numbers, words 
      # separated by underscores.
      def DeepLink.normalize(text)
        result = Unicode::downcase(text.strip)
        result = result.gsub(/\s+/, "_")
        result = result.gsub(/(\w)-(\w)/, "\\1_\\2") # e.g. foo-style -> foo_style
        result = result.gsub(/(\w)'(\w)/, "\\1\\2") # e.g. don't -> dont
        result = result.gsub(/[\]\!\"\#\$\%\&\'\(\)\*\+\,\.\/:;<=>?@\[\\^`{|}~-]/, "")
      end
      
      # Id generator which uses the normalized text content of the element to
      # construct the element's id. This is suited to section headings 
      # (<h1> etc) because the text content of those elements tends to be short
      class ContentIdGenerator
        def generate_id(node)
          DeepLink.normalize(node.content)
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
          words = DeepLink.normalize(node.content).split(/_/)
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

      # TODO Make a static method of Deeplink
      #def normalize(text)
      #  result = text.strip.downcase
      #  result = result.gsub(/\s+/, "_")
      #  result = result.gsub(/(\w)-(\w)/, "\\1_\\2") # e.g. foo-style -> foo_style
      #  result = result.gsub(/(\w)'(\w)/, "\\1\\2") # e.g. don't -> dont
      #  result = result.gsub(/[\]\!\"\#\$\%\&\'\(\)\*\+\,\.\/:;<=>?@\[\\^`{|}~-]/, "")
      #end
      
      # Transformer entry point
      def transform(site, page, rendered)
        if page.output_path.end_with?(".html") 
          doc = Nokogiri::HTML(rendered)
          collector = IdCollectingVisitor.new
          doc.accept(collector)
          doc.accept(IdGeneratingVisitor.new(collector.existing_ids, @id_generators))
          rendered = doc.serialize()
        end
        rendered
      end
    end
  end
end
