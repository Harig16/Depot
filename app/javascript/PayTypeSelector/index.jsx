import React from "react"

import NoPayType from './NoPayType';
import CheckPayType from './checkpaytype';
import CreditCardPayType from './creditcardpaytype'
import PurchaseOrderPayType from './purchaseorderpaytype';

class PayTypeSelector extends React.Component {

  constructor(props) {
    super(props)
    this.onPayTypeSelected = this.onPayTypeSelected.bind(this)
    this.state = { selectedPayType: null }
  }

  onPayTypeSelected(event) {
    console.log(event.target.value);
    this.setState(
      { selectedPayType: event.target.value }
    );
  }

  render() {
    let PayTypeCustomComponent = NoPayType;
    if (this.state.selectedPayType == "Check" ){
      PayTypeCustomComponent = CheckPayType;
    }else if (this.state.selectedPayType == "Credit Card") {
      PayTypeCustomComponent = CreditCardPayType;
    }else if (this.state.selectedPayType == "Purchase Order") {
      PayTypeCustomComponent = PurchaseOrderPayType;
    }

    return(
      <div className="field">
        <label htmlFor="order_pay_type">{I18n.t('orders.form.pay_type')}</label>
        <select onChange={this.onPayTypeSelected} name="order[pay_type]" id="order_pay_type">
          <option value="">{I18n.t('orders.form.pay_prompt_html')}</option>
          <option value="Check">{I18n.t('orders.form.pay_types.check')}</option>
          <option value="Credit Card">{I18n.t('orders.form.pay_types.credit_card')}</option>
          <option value="Purchase Order">{I18n.t('orders.form.pay_types.purchase_order')}</option>
        </select>
        <PayTypeCustomComponent />
      </div>
    );
  }
}
export default PayTypeSelector;