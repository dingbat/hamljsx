require 'test/unit'
require_relative '../lib/engine'

class EngineTests < Test::Unit::TestCase
  def assert_render(haml, jsx)
    whitespaced = HamlJsxEngine.evaluate(haml).gsub(/(>)\s*|\s*(<)/) do
      "#{$1}#{$2}"
    end
    assert_equal jsx.strip, whitespaced.strip
  end

  def test_basic
    assert_render "
      results = (~
        %p.hello
          hi
      ~);",
      "results = (<p className='hello'>hi</p>);"
	end

  def test_comments
    assert_render "
      results = (~
        %p.hello
          /* test */
          // test2
          hi
      ~);",
      "results = (<p className='hello'>hi</p>);"
  end

  def test_dots
    assert_render "
      results = (~
        .
          .(key='hi')
            .hi
              hello
      ~);",
      "results = (<div><div key='hi'><div className='hi'>hello</div></div></div>);"
  end
end
