import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'date', 'morning', 'afternoon', 'afternoonTitle', 'morningTitle' ]

  connect(){
    const day= String(new Date().getDate()).padStart(2, '0')
    const month = String(new Date().getMonth() + 1).padStart(2, '0')
    const year = new Date().getFullYear()
    const date = `${year}-${month}-${day}`
    this.setDisplay(date)
    this.setTitle()
  }

  setReservation(e){
    this.dateTargets.forEach(reservation => reservation.classList.remove('hidden'))
    this.dateTargets.forEach(reservation => reservation.dataset.today = true)
    this.setDisplay(e.detail.date)
    this.setTitle()
  }

  setDisplay(date){ 
    const reservations = this.dateTargets.filter(item => (item.dataset.date != date))
    reservations.forEach(reservation => reservation.classList.add('hidden'))
    reservations.forEach(reservation => reservation.dataset.today = false)
  }

  setTitle(){
    const afternoonCount = [...this.afternoonTarget.children].filter((a) => a.dataset.today == 'true').length
    const morningCount = [...this.morningTarget.children].filter((a) => a.dataset.today == 'true').length

    afternoonCount === 0? this.afternoonTitleTarget.classList.add('hidden') : this.afternoonTitleTarget.classList.remove('hidden')
    morningCount === 0? this.morningTitleTarget.classList.add('hidden') : this.morningTitleTarget.classList.remove('hidden')
  }
}