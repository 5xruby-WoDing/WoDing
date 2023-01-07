import { Controller } from "stimulus"

export default class extends Controller {

  connect(){
    this.timer(5)
  }

  timer(endTime){
    let sec = endTime

    const timer = setInterval(()=>{
      this.element.innerHTML = `${sec}秒後轉跳`
      sec --
      if(sec <= 0){
        clearInterval(timer)
        window.location.href = `/managers/sign_in`
      }
    }, 1000)  

  }
}


