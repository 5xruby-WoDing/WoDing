import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['date', 'sum', 'sumOfPeople']

  connect(){
  }
  setDate(time){
    const day= String(new Date(time).getDate()).padStart(2 ,'0')
    const date = new Date(time).toLocaleString('en-us', {  weekday: 'long' })
    const month = String(new Date(time).getMonth() + 1).padStart(2, '0')
    const year = new Date(time).getFullYear()
    this.dateTarget.textContent = `${year} ${month} 月 ${day} 日 ${date}`
  }
  setPeople(e){
    this.setDate(e.detail.date)
    const sum = e.detail.sum
    const sumOfPeople = e.detail.sum_of_people
    this.sumTarget.textContent = sum
    this.sumOfPeopleTarget.textContent = sumOfPeople
  }
}
