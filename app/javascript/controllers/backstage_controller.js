import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["content1", "content2", "content3"]



    connect() {

    }
    btn1() {
        this.content1Target.classList.remove('hidden')
        this.content2Target.classList.add('hidden')
        this.content3Target.classList.add('hidden')
    }

    btn2() {
        this.content1Target.classList.add('hidden')
        this.content2Target.classList.remove('hidden')
        this.content3Target.classList.add('hidden')
    }
    btn3() {
        this.content1Target.classList.add('hidden')
        this.content2Target.classList.add('hidden')
        this.content3Target.classList.remove('hidden')
    }

}