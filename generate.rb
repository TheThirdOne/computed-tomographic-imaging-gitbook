require 'redcarpet'

class Renderer < Redcarpet::Render::HTML
  def block_code(code, language)
    "<p>\\[#{code}\\]</p>"
  end 
  def codespan(code)
    "\\(#{code}\\)"
  end 
  def image(link, title, alttext)
    "<div class=\"img-container\">"\
    "<div class=\"caption\"><b>#{title}</b>#{alttext}</div>"\
    "<img src=\"#{link}\" alt=\"#{alttext}\" title=\"#{title}\">"\
    "</div>"
  end
  def doc_header()
  %q'<html>
  <head>
  <script type="text/x-mathjax-config">
      MathJax.Hub.Config({
	TeX:{
		equationNumbers: {autoNumber:"all"}
	}	
      });
    </script>
    <script type="text/javascript" async="" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML">
    </script>
    <link rel="stylesheet" type="text/css" href="/theme.css">
  </head>
  <body>'
  end
end

markdown = Redcarpet::Markdown.new(Renderer.new, lax_spacing: true, tables: true, fenced_code_blocks: true)

Dir.glob("**/*.md") do |md|
  html = "#{File.dirname(md)}/#{File.basename(md,'.*')}.html"
  File.open(html, 'w') { |file|
    file.write(markdown.render(File.open(md).read))
  }
  puts "Rendered #{md} to #{html}"
end
