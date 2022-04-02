module StoreHelper

  def visited(count)  
    "Visited: " + pluralize(count, "time")
  end
end
