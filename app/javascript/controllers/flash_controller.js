import { Controller } from "stimulus"
import { library, dom} from '@fortawesome/fontawesome-svg-core'
import { faXmark} from '@fortawesome/free-solid-svg-icons'
export default class extends Controller {

    initialize(){
        library.add(faXmark)
    }
    connect() {
        dom.watch()
        setTimeout(() => {
            this.element.remove();
          }, 4000);
    }
}