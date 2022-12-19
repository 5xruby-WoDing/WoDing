import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["info", "reservationInfo", "setting", 'seat']

    connect() {

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