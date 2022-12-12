import { Controller } from "stimulus"
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ 'input', 'id' ]
  connect() {
  }

  getSeat(e){
    e.preventDefault()
    e.target.classList.remove("reservation-btn")
    e.target.classList.add("confirm-state")
    const seat = e.target.children[0].textContent
    this.setSeat(seat)
  }

  setSeat(seat){ 
    this.inputTarget.value = seat
  }
}