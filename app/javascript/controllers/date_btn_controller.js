import { Controller } from "stimulus"
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ 'input' ]

  connect() {
  }

  getDate(e){
    e.preventDefault()
    e.target.classList.remove("gray-btn")
    e.target.classList.add("confirm-state")
    const date = e.target.textContent
    this.setDate(date)
  } 

  setDate(date){
    this.inputTarget.value = date
  }
}
