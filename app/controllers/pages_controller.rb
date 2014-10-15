class PagesController < ApplicationController

  def index

    quote1 = Quote.new
    quote1.text = "foobar"
    quote1.author = "jeff"

    quote2 = Quote.new
    quote2.text = "baz"
    quote2.author = "Steve"

    quote3 = Quote.new
    quote3.text = "w00t"
    quote3.author = "Lark"

    @quotes = [quote1, quote2, quote3]
  end

end
