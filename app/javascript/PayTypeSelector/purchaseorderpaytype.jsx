import React from 'react'

class PurchaseOrderPayType extends React.Component {
  render() {
    return(
      <div className="field">
        <label htmlFor="order_po_number">PO #</label>
        <input type="password" name="order[po_number]" id="order_po_number" />
      </div>
    );
  }
}

export default PurchaseOrderPayType