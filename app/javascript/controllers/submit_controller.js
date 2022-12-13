import { Controller } from "stimulus"
import log from "tailwindcss/lib/util/log";

export default class extends Controller {
  static targets = [ 'submit' ]

  connect() {
    this.state = this.submitTarget.dataset.state
  }
  setState(){

  }
}
