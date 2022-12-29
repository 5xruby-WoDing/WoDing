import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'submit', 'nameInput', 'emailInput', 'phoneInput', 'nameWarn', 'emailWarn', 'phoneWarn']

  connect() {  
    this.state = false    
  }

  input() {
    this.determineSubmit()    
  } 

  nameFieldBlur() {
    const nameField = this.nameInputTarget.value

    if (nameField === "") {
      this.addWarnDivElement(this.nameWarnTarget, "姓名欄位不可為空")
    } else {
      this.removeWarnDivElement(this.nameWarnTarget)      
    }   
  }

  emailFieldBlur() {
    const emailField = this.emailInputTarget.value

    if (emailField === "") {
      this.addWarnDivElement(this.emailWarnTarget, "信箱欄位不可為空")
    } else if (!emailField.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/)) {
      this.addWarnDivElement(this.emailWarnTarget, "信箱欄位格式錯誤")            
    } else {
      this.removeWarnDivElement(this.emailWarnTarget)            
    }  
  }

  phoneFieldBlur() {
    const phoneField = this.phoneInputTarget.value

    if (phoneField === "") {
      this.addWarnDivElement(this.phoneWarnTarget, "手機欄位不可為空")
    } else if (phoneField.match(/\D/)) {
      this.addWarnDivElement(this.phoneWarnTarget, "格式錯誤，請輸入數字")             
    } else {
      this.removeWarnDivElement(this.phoneWarnTarget)              
    }  
  }

  determineSubmit() {
    let nameState = this.nameInputTarget.value
    let emailState = this.emailInputTarget.value
    let phoneState = this.phoneInputTarget.value

    if (nameState && emailState.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/) && phoneState.match(/\d/) ) {
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
  addWarnDivElement(target, text) {
    target.classList.add("bg-gray-700", "text-white", "rounded", "px-4", "py-2", "my-2", "text-sm")
    target.textContent = text
  }
  removeWarnDivElement(target) {
    target.classList.remove("bg-gray-700", "text-white", "rounded", "px-4", "py-2", "my-2", "text-sm")
    target.textContent = ""
  }
}



