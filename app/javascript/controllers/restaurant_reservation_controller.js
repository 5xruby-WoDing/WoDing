import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'date', 'dateInput', 'time', 'timeInput', 'seat', 'seatInput', 'submit', 'adult', 'child', 'notice', 'seatBtn', 'timeBtn']
  
  getSeat(e){
    e.preventDefault()
    const seat = e.target.value
    this.setSeat(e, seat)
    this.fetchOccupied(e)
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
      this.disabledBtn(btn)

      if(!(pending_time.includes(btn.value))){
        this.releaseBtn(btn)  
      }
    })
  }
  
  disabledBtn(btn){
    btn.classList.add('disabled-btn')
    btn.classList.remove('gray-btn')
    btn.disabled = true
  }

  resetInput(){
    this.seatInputTarget.value = ''
    this.resetSubmit()
  }

  resetState(){
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
    const people = (+this.adultTarget.value ) + (+this.childTarget.value)

    if(this.seatTargets.filter(s => +s.dataset.capacity >= people).length == 0){
      this.noticeTarget.classList.remove('hidden')
      this.seatTargets.forEach(s => s.classList.add('hidden'))
      this.timeTargets.forEach(s => s.classList.add('hidden'))
      this.seatInputTarget.value = ''
      this.TimeInputTarget.value = ''
      this.resetSubmit()

    }else{
      this.noticeTarget.classList.add('hidden')
      this.seatTargets.forEach(s => s.classList.remove('hidden'))
      this.timeTargets.forEach(s => s.classList.remove('hidden'))
    }

    fetch(`/restaurants/${id}/occupied`,{
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
    .then(({over_capacity_seats, occupied_time, occupied_seats_id, all_keys}) => {
      this.setSeatState(over_capacity_seats)
      this.releaseTime(occupied_time)
      this.disableSeat(occupied_seats_id, all_keys)
    })
    .catch(() => {
      console.log("error!!");
    })
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
    this.setDate(e)
    this.fetchOccupied(e)
    this.resetInput()
    this.resetState()
  }

  setDate(e){
    const btnContent = e.target.value

    this.dateInputTarget.value = btnContent
    this.seatTargets.forEach(seat => seat.dataset.date = btnContent)
    this.timeTargets.forEach(time => time.dataset.date = btnContent)
    if(this.dateInputTarget.value === btnContent){
      this.dateTargets.forEach(btn => btn.classList.remove('confirm-state'))
      e.target.classList.add('confirm-state')
    }
    this.determineSubmit()

  }

  releaseTime(occupied_time){
    let today = new Date().toLocaleString('en-US').split(',')[0].split('/')
    today.unshift(today.pop())
    const currentTime =  new Date().toLocaleTimeString('en-US', { hour12: false, 
                                                                  hour: "numeric", 
                                                                  minute: "numeric"})
    this.timeTargets.forEach(btn => {
      this.disabledBtn(btn)

      if(today.join('-') == btn.dataset.date && btn.value < currentTime){
        this.disabledBtn(btn)
      }else if(!(occupied_time.includes(btn.value))){
        this.releaseBtn(btn)
      }
      
    })
  }

  releaseBtn(btn){
    btn.classList.remove('disabled-btn')
    btn.classList.add('gray-btn')
    btn.disabled = false
  }

  getTime(e){
    e.preventDefault()
    this.setTime(e)
    this.fetchOccupied(e)
    this.resetInput()
    this.resetState()
  }

  setTime(e){
    const btnContent = e.target.value

    this.timeInputTarget.value = btnContent
    this.seatTargets.forEach(seat => seat.dataset.time = btnContent)

    if(this.timeInputTarget.value === btnContent ){
      this.timeTargets.forEach(btn => btn.classList.remove('confirm-state'))
      e.target.classList.add('confirm-state')
    }
    this.determineSubmit()
  }

  disableSeat(occupied_seats_id, all_keys){
    this.seatTargets.forEach(btn => {
      this.disabledBtn(btn) 
      btn.classList.remove('chosen-btn')
      if(this.timeInputTarget.value != '' && btn.dataset.state == 'true'){
        this.releaseBtn(btn)
        all_keys.forEach((key) => {
          if(key.arrival_time == btn.dataset.time && key.arrival_date == btn.dataset.date && key.seat_id == btn.value){
            btn.classList.add('chosen-btn')
            btn.classList.remove('gray-btn')
            btn.disabled = true
          }
        })

      }
      if(occupied_seats_id.includes(+btn.value)){
        this.disabledBtn(btn) 
      }
    })
  }

}