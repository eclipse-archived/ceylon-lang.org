require 'rdiscount'
require 'nokogiri'

# Sets the page.title from the page.title_md if the page.title isn't already set.
class TitleFix
  def execute(site)
    site.pages.each do |page|
      next if page.title
      next unless page.title_md
      begin
        if page.is_a?(Awestruct::MarkdownFile)
          fix_title(page)
        end
      rescue NameError
        begin
          if page.is_a?(Awestruct::Handlers::MarkdownHandler)
            fix_title(page)
          end
        rescue NameError
          if page.relative_source_path.end_with? '.md'
            fix_title(page)
          end
        end
      end
    end
  end
  
  def fix_title(page)
    page.title = Nokogiri::XML.fragment(RDiscount.new(page.title_md).to_html).text()
    #puts page.title
  end
end

