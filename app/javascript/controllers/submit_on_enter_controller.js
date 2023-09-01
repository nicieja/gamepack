import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submitOnEnter(event) {
    if (event.keyCode === 13) {
      event.preventDefault()
      document.getElementById("submit").click()
    }
  }
}
