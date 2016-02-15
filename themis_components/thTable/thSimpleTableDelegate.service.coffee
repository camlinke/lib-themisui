angular.module 'ThemisComponents'
.factory 'SimpleTableDelegate', (TableDelegate, $interpolate) ->
  interpolateStart = $interpolate.startSymbol()
  interpolateEnd = $interpolate.endSymbol()

  SimpleTableDelegate = (options = {}) ->
    delegate = TableDelegate options

    {
      headers = []
      generatePaginationTemplate
    } = delegate

    generateHeadersTemplate = ->
      return "" unless headers.length > 0
      return """
        <thead>
          <tr>
            <th ng-repeat="header in thTable.delegate.headers track by $index"
                ng-class="header.cssClasses()"
                ng-click="thTable.delegate.sortData(header)">
              #{interpolateStart}header.name#{interpolateEnd}
              <span class="th-table-sort-icon" aria-hidden="true"></span>
            </th>
          </tr>
        </thead>
      """

    generateColTemplate = ->
      hasSetWidth = (headers.filter (header) -> header.width?).length > 0
      return "" unless hasSetWidth
      return headers
        .map (header) ->
          width = if header.width then "style='width: #{header.width}'" else ""
          """<col #{width}>"""
        .join ''

    generateBodyTemplate = (rows) ->
      numColumns = childrenArray(rows['cells']).length
      cellsRow = generateCellsRowTemplate rows['cells'], rows['actions']?
      actionsRow = generateActionsRowTemplate rows['actions'], numColumns
      noDataRow = generateNoDataRowTemplate rows['no-data'], numColumns
      errorRow = generateErrorRowTemplate numColumns
      return """
        <tbody>
          #{noDataRow}
          #{errorRow}
          #{cellsRow}
          #{actionsRow}
        </tbody>
      """

    generateCellsRowTemplate = (cellsRow, hasActionsRow) ->
      ngRepeat = if hasActionsRow then "ng-repeat-start" else "ng-repeat"
      borderBottomClass = "th-table-border-bottom" unless hasActionsRow
      objectReference = getObjectReference cellsRow
      cells = childrenArray(cellsRow)
                .map (cell) -> generateCellTemplate cell
                .join ''
      return """
        <tr class="th-table-cells-row #{borderBottomClass}"
            #{ngRepeat}="#{objectReference} in thTable.delegate.getData()"
            ng-mouseover="hover = true"
            ng-mouseleave="hover = false"
            ng-class="{'th-table-hover-row': hover}">
          #{cells}
        </tr>
      """

    generateCellTemplate = (cell) ->
      return """
        <td>#{cell.innerHTML}</td>
      """

    generateActionsRowTemplate = (actionsRow, numColumns) ->
      return "" unless actionsRow?
      startColumn = parseInt (actionsRow.getAttribute('start-column') ? 1), 10
      colspan = numColumns - startColumn + 1
      actions = [1 ... startColumn]
                  .map -> """<td class="th-table-actions-cell"></td>"""
                  .join ''
                  .concat """
                    <td class="th-table-actions-cell" colspan=#{colspan}>
                      #{actionsRow.innerHTML}
                    </td>
                  """
      return """
        <tr class="th-table-actions-row th-table-border-bottom"
            ng-repeat-end
            ng-mouseover="hover = true"
            ng-mouseleave="hover = false"
            ng-class="{'th-table-hover-row': hover}">
          #{actions}
        </tr>
      """

    generateNoDataRowTemplate = (noDataRow = {}, numColumns) ->
      contents = noDataRow.innerHTML ? "No Results"
      return """
        <tr class="th-table-no-data-row"
            ng-if="thTable.delegate.hasNoData()">
          <td colspan="#{numColumns}">
            #{contents}
          </td>
        </tr>
      """

    generateErrorRowTemplate = (numColumns) ->
      return """
        <tr class="th-table-error-row"
            ng-if="thTable.delegate.getError()">
          <td colspan="#{numColumns}">
            <th-error>
              <div>
                We had trouble loading your content.
              </div>
              <div>
                <a href ng-click="thTable.delegate.reload()">Try again</a>.
              </div>
            </th-error>
          </td>
        </tr>
      """

    checkValidRows = (rows) ->
      throw new Error "A simple table needs a cells row." unless rows["cells"]?

      cellsRow = rows['cells']
      actionsRow = rows['actions']

      if actionsRow? and
         getObjectReference(actionsRow) isnt getObjectReference(cellsRow)
        throw new Error "object-reference must be the same" + \
                        "for the actions and cells rows."

      if actionsRow?
        startColumn = parseInt (actionsRow.getAttribute('start-column') ? 1), 10
        numColumns = childrenArray(cellsRow).length
        if startColumn > numColumns or startColumn < 1
          throw new Error "start-column must have a value between 1 and " + \
                          "the total number of cells."

    childrenArray = (node) -> [].slice.call node.children

    getObjectReference = (row) -> row.getAttribute('object-reference') or 'item'

    return Object.freeze Object.assign {
      ###
      # This is the single required method that a custom delegate must implement.
      # The rest of the interface is inherited from TableDelegate.
      #
      # It receives as input a dictionary of {type: row} pairs, where the value,
      # row, is a <th-table-row type="...">...</th-table-row> DOM element
      # defined inside the <th-table> element.
      #
      # It must return the final table template that gets compiled in th-table's
      # parent scope, extended with the thTable key, which stores this table's
      # controller. This means you can use thTable.delegate in your template to
      # access the delegate's interface.
      ###
      generateTableTemplate: (rows = {}) ->
        checkValidRows rows
        thead = generateHeadersTemplate()
        tbody = generateBodyTemplate rows
        pagination = generatePaginationTemplate()
        cols = generateColTemplate()
        return """
          <div ng-class="{'th-table-loading': thTable.delegate.isLoading(),
                          'th-table-blank': thTable.delegate.getData().length === 0}">
            <table class="th-table">
              #{cols}
              #{thead}
              #{tbody}
            </table>

            #{pagination}

            <div class="th-table-overlay" ng-if="thTable.delegate.isLoading()">
              <th-loader class="th-table-loader" size="small">&nbsp;</th-loader>
            </div>
          </div>
        """
    }, delegate
