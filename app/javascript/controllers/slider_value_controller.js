import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider-value"
export default class extends Controller {
  static targets = ["bubble" , "range"]
  connect() {
    this.setBubble();
  }
  setBubble() {
    const val = this.rangeTarget.value;
    const min = this.rangeTarget.min ? this.rangeTarget.min : 1;
    const max = this.rangeTarget.max ? this.rangeTarget.max : 5;
    const newVal = Number(((val - min) * 100) / (max - min));
    this.bubbleTarget.innerHTML = val;

    this.bubbleTarget.style.left = `calc(${newVal}% + (${8 - newVal * 0.15}px))`;
  }
}
