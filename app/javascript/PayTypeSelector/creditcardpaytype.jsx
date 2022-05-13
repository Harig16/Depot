import React from 'react'

class CreditCardPayType extends React.Component {
  render() {
    return(
      <div>
        <div className="field">
          <label htmlFor="order_credit_card">{I18n.t('orders.form.credit_card_pay_type.cc')}</label>
          <input type="password" name="order[credit_card]" id="order_credit_card" />
        </div>
        <div className="field">
          <label htmlFor="order_expiration_date">{I18n.t('orders.form.credit_card_pay_type.expire_date')}</label>
          <input type="text" name="order[expiration_date]" size="9" placeholder='eg: 03/23' id="order_expiration_date" />
        </div>
      </div>
    );
  }
}

export default CreditCardPayType