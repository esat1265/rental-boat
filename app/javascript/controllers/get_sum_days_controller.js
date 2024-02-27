import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="get-sum-days"
export default class extends Controller {
  static targets = ["start_date", "end_date", "amount", "price_per_day"]

  sum() {
    let startDate = this._parseDate(this.start_dateTarget.value);
    let endDate = this._parseDate(this.end_dateTarget.value);

    if (!isNaN(endDate) && !isNaN(startDate) !== "") {
      const totalDays = (Math.floor((endDate - startDate) / (1000 * 60 * 60 * 24))) + 1;
      this.amountTarget.innerText = `Total amount for ${totalDays} days: CHF`
    }


    // console.log(this.amountTarget.innerText);
  }

  _parseDate(date){
    const dateParts = date.split(".");
    const dateObject = new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0]);
    return new Date(dateObject)
  }
}
