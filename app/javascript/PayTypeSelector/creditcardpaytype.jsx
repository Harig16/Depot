import React from 'react'

class CreditCardPayType extends React.Component {
  render() {
    return(
      <div>
        <div className="field">
          <label htmlFor="order_credit_card_number">CC #</label>
          <input type="password" name="order[credit_card_number]" id="order_credit_card_number" />
        </div>
        <div className="field">
          <label htmlFor="order_expire_date">Expire Date #</label>
          <input type="text" name="order[expire_date]" size="9" placeholder='eg: 03/23' id="order_expire_date" />
        </div>
      </div>
    );
  }
}

export default CreditCardPayType