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
    const btnContent = e.target.textContent.replace(/\s/g, '')
    this.setDate(e, btnContent)
    this.fetchOccupied(e)
    this.resetInput()
    this.resetState()
  }

  setDate(e, btnContent){
    this.dateInputTarget.value = btnContent
    if(this.dateInputTarget.value === btnContent){
      this.dateTargets.forEach(btn => btn.classList.remove('confirm-state'))
      e.target.classList.add('confirm-state')
    }
    this.determineSubmit()
  }

  getTime(e){
    e.preventDefault()
    const btnContent = e.target.textContent.replace(/\s/g, '')
    this.setTime(e, btnContent)
    this.fetchOccupied(e)
    this.seatInputTarget.value = ''
    this.resetSubmit()
    this.seatTargets.forEach(btn => btn.classList.remove('confirm-state'))
  }

  setTime(e, btnContent){
    this.timeInputTarget.value = btnContent

    if(this.timeInputTarget.value === btnContent ){
      this.timeTargets.forEach(btn => btn.classList.remove('confirm-state'))
      e.target.classList.add('confirm-state')
    }
    this.determineSubmit()
  }

  getSeat(e){
    e.preventDefault()
    const seat = e.target.children[0].textContent.replace(/\s/g, '')
    this.setSeat(e, seat)
  }

  setSeat(e, seat){ 
    this.seatInputTarget.value = seat
    if(this.seatInputTarget.value === seat){
      this.seatTargets.forEach(btn => btn.classList.remove('confirm-state'))
      e.target.classList.add('confirm-state')
    }
    this.determineSubmit()
  }

  determineSubmit(){
    let dateState = this.dateInputTarget.value
    let timeState = this.timeInputTarget.value
    let seatState = this.seatInputTarget.value

    if(dateState && timeState && seatState){
      this.setSubmit()
    }
  }

  setSubmit(){
    this.submitTarget.classList.remove('disabled-btn')
    this.submitTarget.classList.add('major-btn')
    this.submitTarget.disabled = false
  }

  releaseTimeBtn(pending_time){
    this.timeTargets.forEach(btn => {
      btn.classList.add('disabled-btn')
      btn.classList.remove('gray-btn')
      btn.disabled = true
      if(btn.value != pending_time){
        btn.classList.remove('disabled-btn')
        btn.classList.add('gray-btn')
        btn.disabled = false
      }
    })
  }

  releaseSeatBtn(occupied_seats){
    this.seatTargets.forEach(btn => {
      btn.classList.add('disabled-btn')
      btn.classList.remove('gray-btn')
      btn.disabled = true
      if(btn.value != occupied_seats){
        btn.classList.remove('disabled-btn')
        btn.classList.add('gray-btn')
        btn.disabled = false
      }
    })
  }

  resetInput(){
    this.timeInputTarget.value = ''
    this.seatInputTarget.value = ''
    this.resetSubmit()
  }

  resetState(){
    this.timeTargets.forEach(btn => btn.classList.remove('confirm-state'))
    this.seatTargets.forEach(btn => btn.classList.remove('confirm-state'))
  }
  resetSubmit(){
    this.submitTarget.classList.add('disabled-btn')
    this.submitTarget.classList.remove('major-btn')
    this.submitTarget.disabled = true
  }

  fetchOccupied(e){
    const token = document.querySelector("meta[name='csrf-token']").content
    const id = e.target.dataset.id

    fetch(`/restaurants/${id}/determine_occupied`,{
      method: 'POST',
      headers: {
        "X-CSRF-Token": token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        date: this.dateInputTarget.value,
        time: this.timeInputTarget.value,
      })
    }).then((resp) => resp.json())
    .then(({occupied_time, occupied_seats}) => {
      this.releaseTimeBtn(occupied_time)
      this.releaseSeatBtn(occupied_seats)
      
    })
    .catch(() => {
      console.log("error!!");
    });
  }

}

