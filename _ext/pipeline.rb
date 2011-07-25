require 'toc'
require 'mytagger'
require 'my_tag_cloud'

Awestruct::Extensions::Pipeline.new do
  extension Awestruct::Extensions::DataDir.new
  extension Awestruct::Extensions::Posts.new( '/blog', :posts )
  extension Awestruct::Extensions::Paginator.new(:posts, '/blog/index', :per_page => 5 )
  extension Awestruct::Extensions::MyTagger.new( :posts, 
                                               '/blog/index', 
                                               '/blog/tags', 
                                               :per_page=>5 )
  extension Awestruct::Extensions::MyTagCloud.new( :posts, 
                                                '/blog/tags/index.html',
                                                :layout=>'default' )
  extension Awestruct::Extensions::Atomizer.new( :posts, '/blog/blog.atom' )

  extension Awestruct::Extensions::Indexifier.new
  helper Awestruct::Extensions::Partial
  extension TOC.new(:levels => 2)

  helper Awestruct::Extensions::GoogleAnalytics
end



