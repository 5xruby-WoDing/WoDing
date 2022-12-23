import { Controller } from "stimulus"
import consumer from '../channels/consumer';

export default class extends Controller {
  static targets = [ 'date', 'dateInput', 'time', 'timeInput', 'seat', 'seatInput', 'submit', 'adult', 'child', 'notice', 'seatBtn', 'timeBtn']

  connect() {
  }

  // getDate(e){
  //   e.preventDefault()
  //   const btnContent = e.target.textContent.replace(/\s/g, '')
  //   this.setDate(e, btnContent)
  //   this.fetchOccupied(e)
  //   this.resetInput()
  //   this.resetState()
  // }

  // setDate(e, btnContent){
  //   this.dateInputTarget.value = btnContent
  //   if(this.dateInputTarget.value === btnContent){
  //     this.dateTargets.forEach(btn => btn.classList.remove('confirm-state'))
  //     e.target.classList.add('confirm-state')
  //   }
  //   this.determineSubmit()

  // }

  // getTime(e){
  //   e.preventDefault()
  //   const btnContent = e.target.textContent.replace(/\s/g, '')
  //   this.setTime(e, btnContent)
  //   this.fetchOccupied(e)
  //   this.seatInputTarget.value = ''
  //   this.resetSubmit()
  //   this.seatTargets.forEach(btn => btn.classList.remove('confirm-state'))
  // }

  // setTime(e, btnContent){
  //   this.timeInputTarget.value = btnContent

  //   if(this.timeInputTarget.value === btnContent ){
  //     this.timeTargets.forEach(btn => btn.classList.remove('confirm-state'))
  //     e.target.classList.add('confirm-state')
  //   }
  //   this.determineSubmit()
  // }

  // getSeat(e){
  //   e.preventDefault()
  //   const seat = e.target.value
  //   this.setSeat(e, seat)
  //   this.fetchOccupied(e)
  // }

  // setSeat(e, seat){ 
  //   this.seatInputTarget.value = seat
  //   if(this.seatInputTarget.value === seat){
  //     this.seatTargets.forEach(btn => btn.classList.remove('confirm-state'))
  //     e.target.classList.add('confirm-state')
  //   }
  //   this.determineSubmit()
  // }

  // determineSubmit(){
  //   let dateState = this.dateInputTarget.value
  //   let timeState = this.timeInputTarget.value
  //   let seatState = this.seatInputTarget.value

  //   if(dateState && timeState && seatState){
  //     this.setSubmit()
  //   }
  // }

  // setSubmit(){
  //   this.submitTarget.classList.remove('disabled-btn')
  //   this.submitTarget.classList.add('major-btn')
  //   this.submitTarget.disabled = false
  // }

  // releaseTimeBtn(pending_time){
  //   this.timeTargets.forEach(btn => {
  //     this.disabledBtn(btn)

  //     if(!(pending_time.includes(btn.value))){
  //       this.releaseBtn(btn)  
  //     }
  //   })
  // }

  // releaseSeatBtn(occupied_seat){
  //   this.seatTargets.forEach(btn => {
  //     this.disabledBtn(btn)
  //     let occupied_seats = [...new Set(occupied_seat)]
  //     if(!(occupied_seats.includes(+btn.value))){
  //       this.releaseBtn(btn)
  //       this.noticeTarget.classList.add('hidden')
  //       this.seatBtnTarget.classList.remove('hidden')
  //       this.timeBtnTarget.classList.remove('hidden')
  //     }else if(occupied_seats.length == this.seatTargets.length){
  //       this.noticeTarget.classList.remove('hidden')
  //       this.seatBtnTarget.classList.add('hidden')
  //       this.timeBtnTarget.classList.add('hidden')
  //       this.seatInputTarget.value = ''
  //       this.resetSubmit()
  //     }
  //   })
  // }

  // releaseBtn(btn){
  //   btn.classList.remove('disabled-btn')
  //   btn.classList.add('gray-btn')
  //   btn.disabled = false
  // }
  
  disabledBtn(btn){
    btn.classList.add('disabled-btn')
    btn.classList.remove('gray-btn')
    btn.disabled = true
  }

  resetInput(){
    this.timeInputTarget.value = ''
    this.seatInputTarget.value = ''
    // this.resetSubmit()
  }

  resetState(){
    this.timeTargets.forEach(btn => btn.classList.remove('confirm-state'))
    this.seatTargets.forEach(btn => btn.classList.remove('confirm-state'))
  }
  // resetSubmit(){
  //   this.submitTarget.classList.add('disabled-btn')
  //   this.submitTarget.classList.remove('major-btn')
  //   this.submitTarget.disabled = true
  // }

  fetchOccupied(e){
    const token = document.querySelector("meta[name='csrf-token']").content
    const id = e.target.dataset.id
    const people = (+this.adultTarget.value ) + (+this.childTarget.value)

    fetch(`/restaurants/${id}/determine_occupied`,{
      method: 'POST',
      headers: {
        "X-CSRF-Token": token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        date: this.dateInputTarget.value,
        time: this.timeInputTarget.value,
        seat: this.seatInputTarget.value,
        people: people,
        user_id: this.id
      })
    }).then((resp) => resp.json())
    .then(({over_capacity_seats, occupied_time}) => {
    // .then(({occupied_time, capacity_seats}) => {
      this.setSeatState(over_capacity_seats)
      this.releaseTime(occupied_time)

      // this.releaseSeatBtn(capacity_seats)
    })
    .catch(() => {
      console.log("error!!");
    });
  }
  setSeatState(over_capacity_seats){
    this.seatTargets.forEach(seat => seat.dataset.state = true)
    this.seatTargets.forEach(seat => {
      if(over_capacity_seats.includes(+seat.value)){
        seat.dataset.state = false
      }
    })
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
    this.seatTargets.forEach(seat => seat.dataset.date = btnContent)
    if(this.dateInputTarget.value === btnContent){
      this.dateTargets.forEach(btn => btn.classList.remove('confirm-state'))
      e.target.classList.add('confirm-state')
    }
    // this.determineSubmit()

  }
  releaseTime(occupied_time){
    this.timeTargets.forEach(btn => {
      this.disabledBtn(btn)
      if(!(occupied_time.includes(btn.value))){
        this.releaseBtn(btn)
      }
    })
  }

  releaseBtn(btn){
    btn.classList.remove('disabled-btn')
    btn.classList.add('gray-btn')
    btn.disabled = false
  }
}

