import { Controller } from "stimulus"
import { library, dom} from '@fortawesome/fontawesome-svg-core'
import { faHouse, faPlus} from '@fortawesome/free-solid-svg-icons'
export default class extends Controller {
    static targets = ['dom']
    initialize(){
        library.add(faHouse, faPlus)
    }
    connect() {
        dom.watch()
    }
}
