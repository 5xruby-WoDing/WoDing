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
    const afternoon = []
    for (const reservation of this.afternoonTarget.children) {
      afternoon.push(reservation.dataset.today) 
    }
    const afternoonCount = afternoon.filter(t => t === 'true').length
    if (afternoonCount === 0) {
      this.afternoonTitleTarget.classList.add('hidden')
    }else{
      this.afternoonTitleTarget.classList.remove('hidden')
    }

    const morning = []
    for (const reservation of this.morningTarget.children) {
      morning.push(reservation.dataset.today) 
    }
    const morningCount = morning.filter(t => t === 'true').length
    if (morningCount === 0) {
      this.morningTitleTarget.classList.add('hidden')
    }else{
      this.morningTitleTarget.classList.remove('hidden')
    }
  }
}



