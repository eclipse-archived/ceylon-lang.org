require 'toc'

Awestruct::Extensions::Pipeline.new do
  # extension Awestruct::Extensions::Posts.new( '/news' ) 
  extension Awestruct::Extensions::Indexifier.new
  helper Awestruct::Extensions::Partial
  extension TOC.new(:levels => 2)

  # helper Awestruct::Extensions::GoogleAnalytics
end



