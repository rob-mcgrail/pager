class TestPage < MiniTest::Unit::TestCase
  def test_default_body_returns_string
    assert_kind_of String, Page.default_body
  end


  def test_valid_path_returns_boolean
    assert_includes [true, false], Page.valid_path?('test')
  end


  def test_theme_synced_notices_changed_theme
    page = Page.get(1)
    page.css = 'body {color:blue;}'
    page.save
    refute page.theme_synced?
  end


  def test_theme_synced_confirm_unchanged_theme
    page = Page.get(2)
    assert page.theme_synced?
  end


  def test_theme_synced_spots_and_handles_orphaned_theme
    page = Page.get(5)
    theme = Theme.get(page.theme.id)
    theme.destroy!
    page = Page.get(5)
    refute page.theme_synced?
  end
end
