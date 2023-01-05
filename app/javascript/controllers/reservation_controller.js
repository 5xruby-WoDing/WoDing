import { Controller } from "stimulus"

export default class extends Controller {

  initialize(){
    this.key = this.element.dataset.key
  }

  connect() {
    window.addEventListener('beforeunload', () => {
      const token = document.querySelector("meta[name='csrf-token']").content
      const id = this.element.dataset.id

      fetch(`/restaurants/${id}/out`,{
        method: 'POST',
        headers: {
          "X-CSRF-Token": token,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          key: this.key
        })
      })

    })
  }
}
