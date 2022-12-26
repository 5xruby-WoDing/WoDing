import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['date', 'sum', 'sumOfPeople']

  connect(){
  }
  setReservation(e){
    const day= String(new Date(e.detail).getDate()).padStart(2 ,'0')
    const date = new Date(e.detail).toLocaleString('en-us', {  weekday: 'long' })
    const month = String(new Date(e.detail).getMonth() + 1).padStart(2, '0')
    const year = new Date(e.detail).getFullYear()
    this.dateTarget.textContent = `${year} ${month} 月 ${day} 日 ${date}`
  }
  setPeople(e){
    const sum = e.detail.sum
    const sumOfPeople = e.detail.sum_of_people
    this.sumTarget.textContent = sum
    this.sumOfPeopleTarget.textContent = sumOfPeople
  }
}
