class PagesController < PublicController

  def index

    quote1 = Quote.new
    quote1.text = "Failure is not an option.  Everyone has to succeed"
    quote1.author = "Arnold Schwarzenegger"

    quote2 = Quote.new
    quote2.text = "Your time is limited, so don't waste it living someone elses life."
    quote2.author = "Steve Jobs"

    quote3 = Quote.new
    quote3.text = "Better Ingredients, Better Pizza"
    quote3.author = "Papa John"

    @quotes = [quote1, quote2, quote3]
  end

  def faq

    faq1 = Faq.new
    faq1.question = "What is gCamp?"
    faq1.answer = "gCamp is a class project from the galvanize full stack rails and javascript program."

    faq2 = Faq.new
    faq2.question = "How do I get join gCamp?"
    faq2.answer = "You can join it and use it but it's more of an example app."

    faq3 = Faq.new
    faq3.question = "When will gCamp be finished?"
    faq3.answer = "gCamp is an ongoing personal project."

    @faqs = [faq1, faq2, faq3]
  end

end
