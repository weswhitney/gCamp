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

  def faq

    faq1 = Faq.new
    faq1.question = "What is gCamp?"
    faq1.answer = "gCamp is an awesome tool that will change your life."

    faq2 = Faq.new
    faq2.question = "How do I get join gCamp?"
    faq2.answer = "Right now, gCamp is still in production."

    faq3 = Faq.new
    faq3.question = "When will gCamp be finished?"
    faq3.answer = "gCamp is a work in progress."

    @faqs = [faq1, faq2, faq3]
  end

end
