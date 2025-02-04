import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="sortable"
export default class extends Controller {

    static values = {url: String}

    sort(event) {
        const urlParams = new URLSearchParams(document.location.search);
        let currentSortBy = [];
        let currentDirection = [];
        urlParams.forEach((value, key) => {
            {
                if (key.startsWith("sort_by")) {
                    currentSortBy.push(value);
                }
                if (key.startsWith("direction")) {
                    currentDirection.push(value);
                }
            }
        })
        // console.log(currentSortBy)

        let column = event.target.dataset.column;
        console.log("column: " + column)
        const index = currentSortBy.indexOf(column);
        console.log(currentDirection[index])
        // let currentDirectionValue = (index !== -1) ? currentDirection[index] : "asc";
        let currentDirectionValue = currentDirection[index];
        console.log("currentDirectionValue: " + currentDirectionValue)
        let newDirection = currentDirectionValue === undefined ? "asc" : "desc";
        console.log("new direction " + newDirection)

        // Add or update the sorting criteria
        if (index !== -1) {
            if (currentDirectionValue === "desc") {
                currentSortBy.splice(index, 1)
                currentDirection.splice(index, 1)
                newDirection = null
                console.log(currentSortBy)
            } else {
                currentDirection[index] = newDirection
            }
        } else {
            console.log("Adding new col")
            currentSortBy.push(column); // Add new column
            currentDirection.push(newDirection); // Add the new direction
        }

        // Keep the current URL intact but modify the query params
        const url = new URL(window.location.href);
        // Update or add the query params without replacing them entirely
        currentSortBy.forEach((sortColumn, idx) => {
            url.searchParams.set(`sort_by[${idx}]`, sortColumn);
            url.searchParams.set(`direction[${idx}]`, currentDirection[idx]);
        });

        if (newDirection === null) {
            url.searchParams.delete(`sort_by[${index}]`)
            url.searchParams.delete(`direction[${index}]`)
        }

        // Ensure that Turbo visit happens with the updated URL
        Turbo.visit(url, {action: "replace"});
    }
}
