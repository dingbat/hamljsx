require 'haml'

class HamlJsxEngine
  MARKER_START = "(~"
  MARKER_END = "~)"

  def self.evaluate(data)
    result = ""
    offset = 0

    while true
      idx_start = data.index(MARKER_START, offset)
      if idx_start
        idx_start += 1
        idx_end = data.index(MARKER_END, idx_start + MARKER_END.length)-1

        result += data[offset..(idx_start-1)]
        offset = idx_end + MARKER_END.length

        haml = data[(idx_start + MARKER_START.length)..(idx_end-1)]
        
        # Escape { } so they'll survive the HAML render
        haml.gsub!(/\{/,"'{")
        haml.gsub!(/\}/,"}'")

        # Remove spaces offset
        first_indent = haml.match(/\s*/)[0]
        haml.gsub!(/^#{first_indent}/,"")

        # Dot optimization
        haml.gsub!(/^(\s*)\.(\(|$)/,'\1%div\2')

        # Remove comments
        haml.gsub!(/^\s*\/\/.*$/,'')
        haml.gsub!(/\/\*.*?\*\//,'')

        html = Haml::Engine.new(haml).render
        html.gsub!("class=","className=")
        html.gsub!(/\'{/,"{")
        html.gsub!(/\}\'/,"}")

        result += html
      else
        result += data[offset..-1]
        break
      end
    end

    result
  end
end