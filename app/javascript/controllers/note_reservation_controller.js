import { Controller } from "stimulus"
import { library, dom} from '@fortawesome/fontawesome-svg-core'
import { faThumbsUp as thumbsSolid, faStar as faStarSolid } from '@fortawesome/free-solid-svg-icons'
import { faThumbsUp as thumbsRegular, faStar as faStarRegular } from '@fortawesome/free-regular-svg-icons'

export default class extends Controller {
  static targets = [ 'icon', 'text' ]

  initialize () {
    library.add(thumbsSolid, thumbsRegular, faStarSolid, faStarRegular)
  }

  connect() {  
    dom.watch()

    const starState = this.element.dataset.noted
    if (starState === "true") {
      this.setNoteState(true)
    } else{
      this.setNoteState(false)
    }
  }

  noted() {

    const reservationId = this.element.dataset.id
    const token = document.querySelector("meta[name='csrf-token']").content
    
    fetch(`/backstage/reservations/${reservationId}/note`, {
      method: "PATCH", 
      headers: {
        "X-CSRF-Token": token
      }
    })
    .then((resp) => {
      return resp.json()
    })
    .then(({status}) => {
      
      if (status === "has been noted") {
        this.setNoteState(true)
      } else {
        this.setNoteState(false)
      }

    })
    .catch((err) => {
      console.log(err);
    })

  }
  
  setNoteState(state) {
    if (state) {
      this.iconTarget.classList.add("fa-solid")
      this.iconTarget.classList.remove("fa-regular")
    } else {
      this.iconTarget.classList.add("fa-regular")
      this.iconTarget.classList.remove("fa-solid")
    }
  }

}



