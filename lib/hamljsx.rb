require 'tilt'
require 'rails'

class HamlJsxTemplate < Tilt::Template
  MARKER_START = "(~"
  MARKER_END = "~)"

  def prepare
    Haml::Options.defaults[:format] = :xhtml
  end

  def evaluate(context, locals, &block)
    result = ""
    offset = 0

    while true
      idx_start = @data.index(MARKER_START, offset)
      if idx_start
        idx_start += 1
        idx_end = @data.index(MARKER_END, idx_start + MARKER_END.length)-1

        result += @data[offset..(idx_start-1)]
        offset = idx_end + MARKER_END.length

        haml = @data[(idx_start + MARKER_START.length)..(idx_end-1)]
        haml.gsub!(/\{/,"'{")
        haml.gsub!(/\}/,"}'")
        first_indent = haml.match(/\s*/)[0]
        haml.gsub!(/^#{first_indent}/,"")

        haml.gsub!(/^.$/,"%div")

        html = Haml::Engine.new(haml).render
        html.gsub!("class=","className=")
        html.gsub!(/\'{/,"{")
        html.gsub!(/\}\'/,"}")

        result += html
      else
        result += @data[offset..-1]
        break
      end
    end

    result
  end
end

class HamlJsx < Rails::Railtie
  initializer "hamljsx.add_template" do
    Rails.application.assets.register_engine '.haml', HamlJsxTemplate
  end
end
