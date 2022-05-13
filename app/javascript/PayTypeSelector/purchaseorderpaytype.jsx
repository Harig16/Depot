import React from 'react'

class PurchaseOrderPayType extends React.Component {
  render() {
    return(
      <div className="field">
        <label htmlFor="order_po_number">{I18n.t('orders.form.purchase_order_pay_type.po_html')}</label>
        <input type="password" name="order[po_number]" id="order_po_number" />
      </div>
    );
  }
}

export default PurchaseOrderPayType