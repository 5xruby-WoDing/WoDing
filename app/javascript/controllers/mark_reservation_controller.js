import { Controller } from "stimulus"
import { library, icon, dom} from '@fortawesome/fontawesome-svg-core'   
import { faThumbsUp as thumbsSolid, faStar as faStarSolid } from '@fortawesome/free-solid-svg-icons'
import { faThumbsUp as thumbsRegular, faStar as faStarRegular } from '@fortawesome/free-regular-svg-icons'
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ 'text', 'icon' ]

  initialize () {
    library.add(thumbsSolid, thumbsRegular, faStarSolid, faStarRegular)
  }

  connect() {
    dom.watch()
    
    const starState = this.element.dataset.marked
    
    if (starState === "true") {
      this.setMarkState(true)
    } else {
      this.setMarkState(false)
    }


  }

  marked() {

    const reservationId = this.element.dataset.id
    const token = document.querySelector("meta[name='csrf-token']").content

    fetch(`/backstage/reservations/${reservationId}/mark`, {
          method: "PATCH",
          headers: {
            "X-CSRF-Token": token
          }
        }) 
      .then((resp) => {
        return resp.json()
      }) 
      .then(({status}) => {

        if (status === "mark") {
          this.setMarkState(true)
        } else {
          this.setMarkState(false)
        }

      })
      .catch((err) => {
        console.log(err);
      })
  }

  setMarkState(state) {
    if (state) {
      this.iconTarget.classList.add("fa-solid")
      this.iconTarget.classList.remove("fa-regular")
    } else {
      this.iconTarget.classList.add("fa-regular")
      this.iconTarget.classList.remove("fa-solid")
    }
  }


}
