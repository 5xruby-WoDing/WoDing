import { Controller } from "stimulus"
import { library, dom} from '@fortawesome/fontawesome-svg-core'
import { faMagnifyingGlass, faRotateRight } from '@fortawesome/free-solid-svg-icons'
export default class extends Controller {
    static targets = []
    initialize(){
        library.add(faMagnifyingGlass, faRotateRight )
    }
    connect() {
        dom.watch()
    }
}