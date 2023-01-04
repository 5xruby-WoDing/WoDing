import { Controller } from "stimulus"
export default class extends Controller {
    static targets = ['state']
    connect() {
        if(this.element.dataset.state == 'cancelled'){
            this.stateTargets.forEach((e) => e.classList.add('text-red-600'))
        }else if(this.element.dataset.state == 'completed'){
            this.stateTargets.forEach((e) => e.classList.add('text-green-600'))
        }
    }
}