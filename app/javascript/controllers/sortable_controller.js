import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="sortable"
export default class extends Controller {

    static values = {url: String}

    sort(event) {
        console.log("Swapping");
        let column = event.target.dataset.column;
        const urlParams = new URLSearchParams(window.location.search);
        let currentDirection = urlParams.get("direction") || "asc";

        let direction = (currentDirection === "asc" ? "desc" : "asc");
        console.log(`Current direction ${currentDirection} direction ${direction}`)

        const url = new URL(this.urlValue, window.location.origin);
        url.searchParams.set("sort_by", column);
        url.searchParams.set("direction", direction);

        Turbo.visit(url, {action: "replace"});
    }
}
