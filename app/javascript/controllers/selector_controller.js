import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['date']

  getDate(e){
    const date = e.target.dataset.date
    const event = new CustomEvent("update-date", {detail: date});
    window.dispatchEvent(event)
    this.reset()
    e.target.classList.add('confirm-state')
  }

  reset(){
    this.dateTargets.forEach(d => d.classList.remove('confirm-state'));
  }

}