import { Controller } from "stimulus"
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ 'submit', 'nameInput', 'emailInput', 'phoneInput' ]

  connect() {  
    this.state = false
  }

  input() {
    this.determineSubmit()
  }

  determineSubmit() {
    let nameState = this.nameInputTarget.value
    let emailState = this.emailInputTarget.value
    let phoneState = this.phoneInputTarget.value

    if (nameState && emailState && phoneState) {
      this.openSubmit()      
    } else {
      this.closeSubmit()
    }
    this.state = !this.state
  }

  openSubmit() {
    this.submitTarget.classList.remove('disabled-btn')
    this.submitTarget.classList.add('major-btn')
    this.submitTarget.disabled = false
  }

  closeSubmit() {
    this.submitTarget.classList.remove('major-btn')
    this.submitTarget.classList.add('disabled-btn')
    this.submitTarget.disabled = true
  }


}



