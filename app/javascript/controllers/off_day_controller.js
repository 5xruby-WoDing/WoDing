import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['input', 'date', 'offDay', 'submit']

  connect(){
    const offDay = this.offDayTargets.map(a => a.dataset.date)
    this.dateTargets.forEach(btn => {
      if(offDay.includes(btn.dataset.date)){
        btn.classList.add('hidden')
      }
    })
  }
  getDate(e){
    this.dateTargets.forEach(btn => btn.classList.add('gray-btn'))
    this.dateTargets.forEach(btn => btn.classList.remove('major-btn'))
    e.target.classList.remove('gray-btn')
    e.target.classList.add('major-btn')
    this.setDate(e.target.dataset.date)
  }
  setDate(date){
    this.inputTarget.value = date
    this.submitTarget.classList.remove('disabled-btn')
    this.submitTarget.classList.add('major-btn')
  }
}