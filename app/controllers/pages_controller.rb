class PagesController < ApplicationController

  def index
    @quotes = ["foobar", "baz", "w00t"]
  end

end
