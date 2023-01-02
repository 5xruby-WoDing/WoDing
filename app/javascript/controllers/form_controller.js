import { Controller } from "stimulus"
import { library, dom} from '@fortawesome/fontawesome-svg-core'
import { faPencil, faClock} from '@fortawesome/free-solid-svg-icons'
export default class extends Controller {
    static targets = ['dom']
    initialize(){
        library.add(faPencil, faClock)
    }
    connect() {
        dom.watch()
    }
}