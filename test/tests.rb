require 'test/unit'
require_relative '../lib/engine'

class EngineTests < Test::Unit::TestCase
  def assert_render(haml, jsx, strip_white=true)
    rendered = HamlJsxEngine.evaluate(haml)
    rendered.gsub!(/(>|})\s*|\s*({|<)/) do
      "#{$1}#{$2}"
    end if strip_white
    assert_equal jsx.strip, rendered.strip
  end

  def test_basic
    assert_render "
      results = (~
        %p.hello
          {hi}
      ~);",
      "results = (<p className='hello'>{hi}</p>);"

    assert_render "
      results = (~
        %p.hello(key={hi})
      ~);",
      "results = (<p className='hello' key={hi}></p>);"
	end

  def test_spaces
    assert_render "
      results = (~
        %p.hello
          hi
          a
      ~);",
      "results = (<p className='hello'>hi{' '}a</p>);"

    assert_render "
      results = (~
        %p.hello
          hi
          {a.length}
          a
      ~);",
      "results = (<p className='hello'>hi{' '}{a.length}{' '}a</p>);"

    assert_render "
      results = (~
        %p.hello
          {a1}
          {a2}
          a
      ~);",
      "results = (<p className='hello'>{a1}{' '}{a2}{' '}a</p>);"
  end

  def test_comments
    assert_render "
      results = (~
        %p.hello
          /* test */a /* x */
          // test2
          hi
      ~);",
      "results = (<p className='hello'>a{' '}hi</p>);"
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

  def test_class
    assert_render "results = (~ %table(class='hi') ~);",
                  "results = (<table className='hi'></table>);"
  end
end
