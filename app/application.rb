class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/cart/)   #writing /cart path methods ish...
      if @@cart.length == 0         #responds with empty art message if the cart is empty
        resp.write "Your cart is empty"
      else
        @@cart.each do |cart_item|
        resp.write "#{cart_item}\n" #responds with a cart list if there is something in there
        end
      end

    elsif req.path.match(/add/)   # i.e  ./add?item=[value]
      search_term = req.params["item"] #we used items since the test consist of keys: 'item'

      if @@items.include?(search_term)
        resp.write "added #{search_term}"
        @@cart << search_term
      else
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
