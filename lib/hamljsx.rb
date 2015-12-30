require 'tilt'
require 'rails'

require 'engine'

class HamlJsxTemplate < Tilt::Template
  def prepare
    Haml::Options.defaults[:format] = :xhtml
  end

  def evaluate(context, locals, &block)
    HamlJsxEngine.evaluate(@data)
  end
end

class HamlJsx < Rails::Railtie
  initializer "hamljsx.add_template" do
    Rails.application.assets.register_engine '.haml', HamlJsxTemplate
  end
end
