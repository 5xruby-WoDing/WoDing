import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['date']

  connect(){
    this.dateTargets[0].classList.add('confirm-state')
  }

  getDate(e){
    const date = e.target.dataset.date
    this.reset()
    e.target.classList.add('confirm-state')

    const token = document.querySelector("meta[name='csrf-token']").content
    const id = e.target.dataset.id
    fetch(`/backstage/restaurants/${id}/reservations/statistics`,{
      method: 'POST',
      headers: {
        "X-CSRF-Token": token,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        date: e.target.dataset.date
      })
    }).then((resp) => resp.json())
    .then(({sum, sum_of_people, morning_number, afternoon_number}) => {
      const event = new CustomEvent("update-info", {detail: {sum: sum, sum_of_people: sum_of_people, date: date,  morning_number: morning_number, afternoon_number: afternoon_number}});
      window.dispatchEvent(event)
    })
    .catch(() => {
      console.log("error!!");
    })
  }

  reset(){
    this.dateTargets.forEach(d => d.classList.remove('confirm-state'));
  }

}
