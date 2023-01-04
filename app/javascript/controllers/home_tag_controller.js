import { Controller } from "stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  static targets = [ 'tagSection', 'searchInput' ]

  connect() {  
    this.state = true
    this.searchBar = true
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

  searchBarSubmit(event) {
    console.log(event.srcElement[0]);
    if ((event.srcElement[0].value).replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g,"") ===  "" ) {      
      window.location = `/`      
    }
  }
}

