module CucumberHelper
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end

World(CucumberHelper)