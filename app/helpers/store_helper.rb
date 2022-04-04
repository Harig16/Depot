module StoreHelper

  def visited(count) 
    if count.present? && 5 < count
      "Visited: " + pluralize(count, "time")
    end
  end
end
