require 'extend_string'

module Awestruct
  module Extensions
    module Sanitizer
      def sanitize(string)
        #replace accents with unaccented version, go lowercase and replace and space with dash
        string.to_s.urlize({:convert_spaces=>true})
      end
    end
  end
end