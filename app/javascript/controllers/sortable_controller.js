import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static values = {url: String}

    sort(event) {
        const url = new URL(window.location.href)
        const params = url.searchParams
        const column = event.target.dataset.column

        const currentSort = this.getCurrentSort(params)

        const existingSortIndex = currentSort.findIndex(([col]) => col === column)
        let newSort = []

        if (existingSortIndex > -1) {
            const [_, currentDirection] = currentSort[existingSortIndex]
            if (currentDirection === 'asc') {
                newSort = [
                    ...currentSort.slice(0, existingSortIndex),
                    [column, 'desc'],
                    ...currentSort.slice(existingSortIndex + 1)
                ]
            } else {
                newSort = currentSort.filter((_, i) => i !== existingSortIndex)
            }
        } else {
            newSort = [...currentSort, [column, 'asc']]
        }

        this.removeSortParams(params)

        newSort.forEach(([col, dir]) => {
            params.append('sort_by[]', col)
            params.append('direction[]', dir)
        })

        Turbo.visit(url.toString(), {action: 'advance'})
    }

    getCurrentSort(params) {
        const sortBy = params.getAll('sort_by[]')
        const directions = params.getAll('direction[]')
        return sortBy.map((col, i) => [col, directions[i] || 'asc'])
    }

    removeSortParams(params) {
        params.delete('sort_by[]')
        params.delete('direction[]')

        const keysToDelete = []
        params.forEach((_, key) => {
            if (key.startsWith('sort_by[') || key.startsWith('direction[')) {
                keysToDelete.push(key)
            }
        })
        keysToDelete.forEach(key => params.delete(key))
    }
}