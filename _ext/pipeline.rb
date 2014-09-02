require 'toc'
require 'mytagger'
require 'mypaginator'
require 'my_tag_cloud'
require 'authorsplitter'
require 'multiatomizer'
require 'mydisqus'
require 'gsub'
require 'deeplink'
require 'sanitizer'
require 'main_atomizer'
require 'titlefix'

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
  # The current limitation is that the MultiAtomizer does not take array of tags into account
  #extension Awestruct::Extensions::MultiAtomizer.new( :posts, 'tags', '/blog/tags' )
  extension Awestruct::Extensions::AuthorSplitter.new( :posts, 
                                              '/blog/index', 
                                              '/blog/authors', 
                                              :per_page=>5 )
  extension Awestruct::Extensions::MyTagCloud.new( :posts, 
                                                '/blog/authors/index.html',
                                                :layout=>'default',
                                                :title=>'Authors',
                                                :items_property_suffix=>'authors' )

  extension Awestruct::Extensions::MainAtomizer.new( :posts, '/blog/blog.atom' )
  extension Awestruct::Extensions::MultiAtomizer.new( :posts, 'author', '/blog/authors' )

  extension Awestruct::Extensions::Indexifier.new
  extension Awestruct::Extensions::MyDisqus.new
  helper Awestruct::Extensions::Partial
  extension TOC.new(:levels => 2)
  extension TitleFix.new
  helper Awestruct::Extensions::GoogleAnalytics
  helper Awestruct::Extensions::Sanitizer

  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*lang:\s*ceylon\s*--\>\s*<pre><code>(.*?)<\/code><\/pre>/, 
    "<pre data-language=\"ceylon\"><code>\\1</code></pre>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*lang:\s*java\s*--\>\s*<pre><code>(.*?)<\/code><\/pre>/, 
    "<pre data-language=\"java\"><code>\\1</code></pre>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*lang:\s*(?:bash|shell)\s*--\>\s*<pre><code>(.*?)<\/code><\/pre>/, 
    "<pre data-language=\"shell\"><code>\\1</code></pre>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*lang:\s*js\s*--\>\s*<pre><code>(.*?)<\/code><\/pre>/, 
    "<pre data-language=\"javascript\"><code>\\1</code></pre>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*lang:\s*javascript\s*--\>\s*<pre><code>(.*?)<\/code><\/pre>/, 
    "<pre data-language=\"javascript\"><code>\\1</code></pre>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*lang:\s*html\s*--\>\s*<pre><code>(.*?)<\/code><\/pre>/, 
    "<pre data-language=\"html\"><code>\\1</code></pre>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*lang:\s*none\s*--\>\s*<pre><code>(.*?)<\/code><\/pre>/, 
    "<pre><code>\\1</code></pre >")
  transformer Awestruct::Extensions::Gsub.new(
    /<pre><code>(.*?)<\/code><\/pre>/, 
    "<pre data-language=\"ceylon\"><code>\\1</code></pre>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<title\>(.*?)\&amp\;\#58\;(.*?)\<\/title\>/,
    "<title>\\1:\\2</title>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*m1\s*--\>\s*/, 
    "<span class='milestone' title='Support for this feature was introduced in Milestone 1'>Milestone 1</span>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*m2\s*--\>\s*/, 
    "<span class='milestone' title='Support for this feature was introduced in Milestone 2'>Milestone 2</span>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*m3\s*--\>\s*/, 
    "<span class='milestone' title='Support for this feature was introduced in Milestone 3'>Milestone 3</span>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*m4\s*--\>\s*/, 
    "<span class='milestone' title='Support for this feature was introduced in Milestone 4'>Milestone 4</span>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*m5\s*--\>\s*/, 
    "<span class='milestone' title='Support for this feature was introduced in Milestone 5'>Milestone 5</span>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*m6\s*--\>\s*/, 
    "<span class='milestone' title='Support for this feature was introduced in Milestone 6'>Milestone 6</span>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*1.1\s*--\>\s*/, 
    "<span class='milestone' title='Support for this feature was introduced in version 1.1'>1.1</span>")
  transformer Awestruct::Extensions::Gsub.new(
    /\<!--\s*m-later\s*--\>\s*/, 
    "<span class='milestone future'><a href='/documentation/1.1/roadmap/' title='Support for this feature will be introduced in Ceylon 1.2 or later'>Ceylon 1.2 or later</a></span>")
    
  transformer Awestruct::Extensions::DeepLink.new
end



