import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clickable-row"
export default class extends Controller {
  static values = {
    url: String
  }
  connect() {
  }

  goToUrl() {
    Turbo.visit(this.urlValue)
  }
}
