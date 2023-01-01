import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'date' ]

  connect(){
    const day= new Date().getDate().padStart(2, '0')
    const month = (new Date().getMonth() + 1).padStart(2, '0')
    const year = new Date().getFullYear()
    const date = `${year}-${month}-${day}`
    this.setDisplay(date)
  }

  setReservation(e){
    this.dateTargets.forEach(reservation => reservation.classList.remove('hidden'))
    this.setDisplay(e.detail.date)
  }

  setDisplay(date){
    console.log(date);
    const reservations = this.dateTargets.filter(item => (item.dataset.date != date))
    reservations.forEach(reservation => reservation.classList.add('hidden'))
  }
}



