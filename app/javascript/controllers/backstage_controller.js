import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["info", "reservationInfo", "setting", 'seat']

    connect() {

    }
    info() {
        this.infoTarget.classList.remove('hidden')
        this.reservationInfoTarget.classList.add('hidden')
        this.settingTarget.classList.add('hidden')
        this.seatTarget.classList.add('hidden')
    }

    reservatoinBtn() {
        
        this.infoTarget.classList.add('hidden')
        this.reservationInfoTarget.classList.remove('hidden')
        this.settingTarget.classList.add('hidden')
        this.seatTarget.classList.add('hidden')
    }

    seat() {
        this.infoTarget.classList.add('hidden')
        this.reservationInfoTarget.classList.add('hidden')
        this.settingTarget.classList.add('hidden')
        this.seatTarget.classList.remove('hidden')
    }
    setting() {
        this.infoTarget.classList.add('hidden')
        this.reservationInfoTarget.classList.add('hidden')
        this.settingTarget.classList.remove('hidden')
        this.seatTarget.classList.add('hidden')
    }

}