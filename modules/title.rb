helpers do
  def title(arg = nil)
    @title = arg ? 'pager | ' + arg : @title = 'pager'
  end
end
