import { Controller } from "stimulus"
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ 'input', 'id', 'btn' ]
  connect() {
  }

  getSeat(e){
    e.preventDefault()

    const btn = e.target
    const btnValue = btn.value

    const seat = e.target.children[0].textContent.replace(/\s/g, '')
    this.setSeat(seat)
    const inputValue = this.inputTarget.value

    if(inputValue === btnValue){
      this.btnTargets.forEach(btn => btn.classList.remove('confirm-state'))
      btn.classList.add('confirm-state')
    }
  }

  setSeat(seat){ 
    this.inputTarget.value = seat
  }
}