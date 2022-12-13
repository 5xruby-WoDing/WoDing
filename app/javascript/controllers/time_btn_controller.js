import { Controller } from "stimulus"
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ 'input', 'btn' ]

  connect() {
  }

  getTime(e){
    e.preventDefault()
    const time = e.target.textContent.replace(/\s/g, '')
    this.setTime(time)

    const btn = e.target
    const btnContent = btn.textContent.replace(/\s/g, '')
    const inputValue = this.inputTarget.value

    if(inputValue == btnContent ){
      this.btnTargets.forEach(btn => btn.classList.remove('confirm-state'))
      btn.classList.add('confirm-state')
    }
  }
  setTime(time){
    this.inputTarget.value = time
  }

}
