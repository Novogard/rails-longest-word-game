import Sortable from "sortablejs"


import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["input", "output", "letters", "answer"]


  letters = []
  vowels = "AEIOUY"
  consonants = "BCDFGHJKLMNPQRSTVWXZ"

  connect() {
    console.log("connected")
      Sortable.create(this.inputTarget, {
      group: 'shared',
      animation: 150,})
      Sortable.create(this.outputTarget, {
      group: 'shared',
      animation: 150})
  }

  consonant() {
    if (this.letters.length < 10) {
    const randomIndex = Math.floor(Math.random() * this.consonants.length);
    this.letters.push(this.consonants[randomIndex]);
    this.inputTarget.innerHTML += `<li class="letter-tile">${(this.consonants[randomIndex])}</li>`;
  }}

  vowel() {
  if (this.letters.length < 10) {
    const randomIndex = Math.floor(Math.random() * this.vowels.length);
    this.letters.push(this.vowels[randomIndex]);
    this.inputTarget.innerHTML += `<li class="letter-tile">${(this.vowels[randomIndex])}</li>`;
  }}

  salute(event) {
    let answerWord = ""
    console.log(this.outputTarget.textContent)
    this.lettersTarget.value = this.letters
    this.answerTarget.value = this.outputTarget.textContent
  }
}
