
Awestruct::Extensions::Pipeline.new do
  # extension Awestruct::Extensions::Posts.new( '/news' ) 
  extension Awestruct::Extensions::Indexifier.new
  helper Awestruct::Extensions::Partial
  # helper Awestruct::Extensions::GoogleAnalytics
end



