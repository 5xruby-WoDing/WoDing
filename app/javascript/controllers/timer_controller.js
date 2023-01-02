import { Controller } from "stimulus"

export default class extends Controller {

  connect(){
    this.timer(5)
  }

  timer(endTime){
    let time = endTime * 60
        
    setInterval(()=>{
      const mins = ("" + (Math.floor(time / 60))).padStart(2, 0)
      let secs = ("" + (Math.floor(time % 60))).padStart(2, 0)
      this.element.innerHTML = `${mins}:${secs}`
      time --
      if(time <= 0){
        const token = document.querySelector("meta[name='csrf-token']").content
        const id = this.element.id

        fetch(`/restaurants/${id}/out`,{
          method: 'POST',
          headers: {
            "X-CSRF-Token": token,
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            key:this.element.dataset.key
          })
        })
        clearInterval(this.timer())
        window.location.href = `/restaurants/${id}`

      }
    }, 1000)  

  }
}


