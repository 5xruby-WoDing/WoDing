import { Controller } from "stimulus"
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ 'date', 'dateInput', 'time', 'timeInput', 'seat', 'seatInput', 'submit']

  connect() {
    this.state = !this.submitTarget.dataset.state
    this.determineSubmit(this.state)
  }

  getDate(e){
    e.preventDefault()
    const date = e.target.textContent.replace(/\s/g, '')
    this.setDate(date)
    
    const btn = e.target
    const btnContent = btn.textContent.replace(/\s/g, '')
    const dateInputValue = this.dateInputTarget.value
  
    if(dateInputValue === btnContent){

      this.dateTargets.forEach(btn => btn.classList.remove('confirm-state'))
      btn.classList.add('confirm-state')
    }
  }

  setDate(date){
    this.dateInputTarget.value = date
    this.determineSubmit()
  }

  getTime(e){
    e.preventDefault()
    const time = e.target.textContent.replace(/\s/g, '')
    this.setTime(time)
  
    const btn = e.target
    const btnContent = btn.textContent.replace(/\s/g, '')
    const timeInputValue = this.timeInputTarget.value
  
    if(timeInputValue === btnContent ){
      this.timeTargets.forEach(btn => btn.classList.remove('confirm-state'))
      btn.classList.add('confirm-state')
    }
  }

  setTime(time){
    this.timeInputTarget.value = time
    this.determineSubmit()
  }

  getSeat(e){
    e.preventDefault()

    const btn = e.target
    const btnValue = btn.value

    const seat = e.target.children[0].textContent.replace(/\s/g, '')
    this.setSeat(seat)
    const seatInputValue = this.seatInputTarget.value

    if(seatInputValue === btnValue){
      this.seatTargets.forEach(btn => btn.classList.remove('confirm-state'))
      btn.classList.add('confirm-state')
    }
  }

  setSeat(seat){ 
    this.seatInputTarget.value = seat
    this.determineSubmit()
  }

  determineSubmit(){
    let dateState = this.dateInputTarget.value
    let timeState = this.timeInputTarget.value
    let seatState = this.seatInputTarget.value

    if(dateState != '' && timeState != '' && seatState != ''){
      this.setSubmit()
    }
  }

  setSubmit(){
    this.submitTarget.classList.remove('disabled-btn')
    this.submitTarget.classList.add('major-btn')
    this.submitTarget.disabled = false
  }
}



