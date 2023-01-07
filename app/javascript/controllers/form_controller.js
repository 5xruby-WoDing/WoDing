import { Controller } from "stimulus"
import { library, dom} from '@fortawesome/fontawesome-svg-core'
import { faPencil, faClock, faGear, faX} from '@fortawesome/free-solid-svg-icons'
export default class extends Controller {
    initialize(){
        library.add(faPencil, faClock, faGear, faX)
    }
    connect() {
        dom.watch()
    }
}