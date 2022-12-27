import { Controller } from "stimulus"
import { library, dom} from '@fortawesome/fontawesome-svg-core'
import { faPenToSquare ,faTrash} from '@fortawesome/free-solid-svg-icons'
export default class extends Controller {
    static targets = ['dom']
    initialize(){
        library.add(faPenToSquare ,faTrash)
    }
    connect() {
        dom.watch()
    }
}