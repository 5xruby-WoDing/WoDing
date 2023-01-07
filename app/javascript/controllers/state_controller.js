import { Controller } from "stimulus"
export default class extends Controller {
    static targets = ['state']
    connect() {
        const styles = {
            'cancelled': 'text-red-600', 
            'completed': 'text-green-600'
        }
        
        const className = styles[this.element.dataset.state]
        this.stateTargets.forEach((e) => e.classList.add(className))
    }
}