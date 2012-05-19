class TestTheme < MiniTest::Unit::TestCase
  def test_extract_name_returns_first_line_of_file_as_string
    theme = File.new('./test/mocks/test.css')
    name = Theme.extract_name(theme)
    assert_kind_of String, name
    assert_equal 'Testing', name
  end


  def test_extract_css_returns_all_but_first_line_of_file_as_string
    theme = File.new('./test/mocks/test.css')
    css = Theme.extract_css(theme)
    assert_kind_of String, css
    assert_equal 8, css.lines.count
    refute_equal 'Testing', css.lines.first.chomp
  end


  def test_ingest_file_returns_theme
    theme = Theme.ingest_file(File.new('./test/mocks/test.css'))
    assert_kind_of Theme, theme
    assert_equal 'Testing', theme.name
    assert_kind_of String, theme.css
  end


  def test_default_returns_a_theme
    theme = Theme.default
    assert_kind_of Theme, theme
  end
end
