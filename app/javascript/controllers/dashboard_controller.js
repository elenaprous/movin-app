import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["searches", "preferences", "searchesTrigger", "preferencesTrigger"]

  toggleSearches() {
    this.searchesTarget.classList.remove("d-none")
    this.preferencesTarget.classList.add("d-none")
    this.searchesTriggerTarget.classList.add("search-highlight")
    this.preferencesTriggerTarget.classList.remove("search-highlight")
  }

  togglePreferences() {
    this.searchesTarget.classList.add("d-none")
    this.preferencesTarget.classList.remove("d-none")
    this.searchesTriggerTarget.classList.remove("search-highlight")
    this.preferencesTriggerTarget.classList.add("search-highlight")
  }

  save() {
    this.element.value = "Saved!"
    console.log(this.element)
  }
}
