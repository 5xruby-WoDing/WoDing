import { Controller } from "stimulus"
export default class extends Controller {
    static targets = ['state']
    connect() {
        if(this.element.textContent.match(/取消/)){
            this.stateTargets.forEach((e) => e.classList.add('text-red-600'))
        }else if(this.element.textContent.match(/完成/)){
            this.stateTargets.forEach((e) => e.classList.add('text-green-600'))
        }
    }
}