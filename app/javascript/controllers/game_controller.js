import Sortable from "sortablejs"


import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["input", "output", "letters", "answer", "previous"]

  baseUrl = "https://dictionary.lewagon.com/"
  score = 0
  points = 0
  roundsPlayed = 0
  validWordsPlayed = 0
  invalidWordsPlayed = 0
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

  compute() {
    answer = this.outputTarget.textContent.trim()
    url = this.baseUrl + word
    fetch(url)
      .then (response => response.json)
      .then (data => {
        if (data["found"] === true) {
          this.points = word.length
          score += points
          this.roundsPlayed += 1
          this.validWordsPlayed += 1
        }  else {
          this.points = 0
          this.roundsPlayed += 1
          this.invalidWordsPlayed += 1
        }
      })
    this.previousTarget.innerHTML = `<li>Letters: ${this.letters}<br>
    Word played: ${this.outputTarget.textContent}`
  }
}
