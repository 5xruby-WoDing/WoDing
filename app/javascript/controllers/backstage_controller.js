import { Controller } from "stimulus"
import { library, dom} from '@fortawesome/fontawesome-svg-core'
import { faGear, faLock, faTrash, faPenToSquare, faUtensils, faStore, faPhone, faLocationDot } from '@fortawesome/free-solid-svg-icons'
export default class extends Controller {
    static targets = ["info", "reservationInfo", "setting", 'seat', 'dom']
    initialize(){
        library.add(faGear, faLock, faTrash, faPenToSquare, faUtensils, faStore, faPhone, faLocationDot )
    }
    connect() {
        dom.watch()
    }
    info() {
        this.resetBtn()
        this.infoTarget.classList.remove('hidden')
    }

    reservatoinBtn() {
        this.resetBtn()
        this.reservationInfoTarget.classList.remove('hidden')
    }

    seat() {
        this.resetBtn()
        this.seatTarget.classList.remove('hidden')
    }
    setting() {
        this.resetBtn()
        this.settingTarget.classList.remove('hidden')
    }
    resetBtn(){
        this.infoTarget.classList.add('hidden')
        this.reservationInfoTarget.classList.add('hidden')
        this.settingTarget.classList.add('hidden')
        this.seatTarget.classList.add('hidden')
    }

}