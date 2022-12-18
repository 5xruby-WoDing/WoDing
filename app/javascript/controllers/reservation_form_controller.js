import { Controller } from "stimulus"
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ 'submit', 'nameInput', 'emailInput', 'phoneInput' ]

  connect() {  
    this.state = false
  }


  setform() {
    this.determineSubmit()
  }

  setName() {

  }

  determineSubmit() {
    let nameState = this.nameInputTarget.value
    let emailState = this.emailInputTarget.value
    let phoneState = this.phoneInputTarget.value

    if (nameState && emailState && phoneState) {
      this.openSubmit()
      this.state = true
    } else {
      this.closeSubmit()
      this.state = false
    }

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




// setform() {
//   //   const formField = document.querySelector(".form")
//   //   const el = `<div>名字為必填欄位</div>`

//   //   if (this.nameInputTarget.value === "" ) {
//   //     formField.insertAdjacentHTML("afterbegin", el)
//   //   } else {
//   //     el.remove()
//     // }

//     this.determineSubmit()
//     this.state = true

//   }