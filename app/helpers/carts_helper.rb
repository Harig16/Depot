module CartsHelper

  def render_order(line_item)
    render line_item.order("id ASC")
  end
end
