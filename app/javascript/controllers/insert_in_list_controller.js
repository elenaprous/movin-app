import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ["items", "form", "input"]

  send(event) {
    event.preventDefault();

    fetch((this.formTarget.action), {
      method: "PATCH",
      headers: { "Accept": "application/json"},
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.address_add) {
          this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
          this.element.querySelector('.mapboxgl-ctrl-geocoder--input').value = ''
          this.inputTarget.value = '';
        }
      })
  }
}
