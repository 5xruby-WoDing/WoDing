import { Controller } from "stimulus"
import { library, dom} from '@fortawesome/fontawesome-svg-core'
import { faGear, faUtensils, faStore, faPhone, faLocationDot} from '@fortawesome/free-solid-svg-icons'
export default class extends Controller {
    static targets = ['dom']
    initialize(){
        library.add(faGear, faUtensils, faStore, faPhone, faLocationDot)
    }
    connect() {
        dom.watch()
    }
}