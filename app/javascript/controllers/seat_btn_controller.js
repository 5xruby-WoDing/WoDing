import { Controller } from "stimulus"
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ '' ]

  connect() {
  }

  getSeat(e){
    e.preventDefault()
    e.target.classList.remove("reservation-btn")
    e.target.classList.add("confirm-state")
  }
}
