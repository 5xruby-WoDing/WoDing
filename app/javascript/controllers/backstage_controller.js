import { Controller } from "stimulus"
import { library, dom} from '@fortawesome/fontawesome-svg-core'
import { faGear, faLock, faTrash, faPenToSquare, faUtensils, faStore, faPhone, faLocationDot, faMagnifyingGlass, faRotateRight } from '@fortawesome/free-solid-svg-icons'
export default class extends Controller {
    static targets = ["info", "reservationInfo", "setting", 'seat', 'dom', 'reservationtBtn', 'reservationBtn', 'seatBtn', 'settingBtn']
    initialize(){
        library.add(faGear, faLock, faTrash, faPenToSquare, faUtensils, faStore, faPhone, faLocationDot, faMagnifyingGlass, faRotateRight )
    }
    connect() {
        dom.watch()
    }
    info(e) {
        this.resetBtn(e)
        this.infoTarget.classList.remove('hidden')
        this.clickBtn(e)
    }

    reservatoin(e) {
        this.resetBtn(e)
        this.reservationInfoTarget.classList.remove('hidden')
        this.clickBtn(e)
    }

    seat(e) {
        this.resetBtn(e)
        this.seatTarget.classList.remove('hidden')
        this.clickBtn(e)
    }
    setting(e) {
        this.resetBtn(e)
        this.settingTarget.classList.remove('hidden')
        this.clickBtn(e)
    }
    resetBtn(e){
        this.infoTarget.classList.add('hidden')
        this.reservationInfoTarget.classList.add('hidden')
        this.settingTarget.classList.add('hidden')
        this.seatTarget.classList.add('hidden')

        this.reservationtBtnTarget.classList.remove('backstage-click-nav-btn')
        this.reservationBtnTarget.classList.remove('backstage-click-nav-btn')
        this.seatBtnTarget.classList.remove('backstage-click-nav-btn')
        this.settingBtnTarget.classList.remove('backstage-click-nav-btn')
    }

    clickBtn(e){
        e.target.classList.add('backstage-click-nav-btn')
    }
}