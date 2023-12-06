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

    // Sorta magic numbers based on size of the native UI thumb
    this.bubbleTarget.style.left = `calc(${newVal}% + (${8 - newVal * 0.15}px))`;
  }
}
  // const range = wrap.querySelector(".range");
  // const bubble = wrap.querySelector(".bubble");

  // range.addEventListener("input", () => {
  //   setBubble(range, bubble);
  // });
  // setBubble(range, bubble);
