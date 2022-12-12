import { Controller } from "stimulus"
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ 'input' ]

  connect() {
  }

  getTime(e){
    e.preventDefault()
    e.target.classList.remove("gray-btn")
    e.target.classList.add("confirm-state")
    const time = e.target.textContent
    this.setTime(time)
  }
  setTime(time){
    this.inputTarget.value = time
  }
}
