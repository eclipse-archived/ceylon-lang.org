require 'rdiscount'

class TOC
  def initialize(options = {})
    @options = {
        :levels => 2,
        :generate_header_links => false
    }.merge(options)
  end

  def execute(site)
    site.pages.each do |page|
      next unless page.toc # only for pages with toc: true in their metadata
      next if page.table_of_contents # only do this once
      toc = ""
      # Necessary to support old Awestruct
      # remove when everyone has moved
      begin
        if page.is_a?(Awestruct::MarkdownFile)
          toc = parse_markdown_headers(page.raw_page_content)
        elsif page.is_a?(Awestruct::TextileFile)
          toc = parse_textile_headers(page.raw_page_content)
        end
      rescue NameError
        begin
          if page.is_a?(Awestruct::Handlers::MarkdownHandler)
            toc = parse_markdown_headers(page.raw_page_content)
          elsif page.is_a?(Awestruct::Handlers::TextileHandler)
            toc = parse_textile_headers(page.raw_page_content)
          end
        rescue NameError
          if page.relative_source_path.end_with? '.md'
            toc = parse_markdown_headers(page.raw_content)
          elsif page.relative_source_path.end_with? '.textile'
            toc = parse_textile_headers(page.raw_content)
          else
            #puts page.relative_source_path
          end
        end
      end
      page.table_of_contents = toc
    end
  end

  def titleable(title)
    title.strip.downcase.gsub(/\s+/, "_").gsub(/\W+/, "_").gsub(/_+/, '_').gsub(/_+$/, '')
  end

  def parse_markdown_headers(content)
    toc = "<div class='toc'><h2>Contents</h2>"
    last_depth = 0
    content.gsub!(/^(\#{2,6})[ ]+(.+?)[ ]*\#*\n+/) do |match|
      number = $1.size.to_i
      name = $2.strip
      header = titleable(name)
      htmlHeader = RDiscount.new(match).to_html.gsub(/<[Hh][1-6]>/, "").gsub(/<\/[Hh][1-6]>/, "")
      if ( number > last_depth ) 
        last_depth.upto( number -1) do |e|
          toc << "<ul>"
        end
      elsif ( number.to_i < last_depth )
        last_depth.downto( number +1 ) do |e|
          toc << "</ul>"
        end
      end

      toc << "<li><a href='##{header}'>#{htmlHeader}</a></li>" 



      last_depth = number

      "<h#{number} id=\"#{header}\">#{htmlHeader}</h#{number}>\n\n"
    end

    number = 1
    if ( number.to_i < last_depth )
      last_depth.downto( number ) do |e|
        toc << "</ul>"
      end
    end

    toc << "</div>"

    toc
  end

end
