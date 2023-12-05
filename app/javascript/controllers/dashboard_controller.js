import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["searches", "preferences"]

  toggle() {
    this.searchesTarget.classList.toggle("d-none")
    this.preferencesTarget.classList.toggle("d-none")
  }
}
