import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'tagSection' ]

  connect() {  
    this.state = true
  }
  setTagSection(e) {
    e.preventDefault()
    if (this.state) {
      this.tagSectionTarget.classList.remove('hidden')
      e.srcElement.textContent = "關閉標籤搜尋"
    } else {
      this.tagSectionTarget.classList.add('hidden')
      e.srcElement.textContent = "標籤搜尋"
    }
    this.state = !this.state
  }
}



