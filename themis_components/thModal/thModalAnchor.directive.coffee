angular.module("ThemisComponents")
  .directive "thModalAnchor", ->
    restrict: "EA"
    replace: true
    controllerAs: "anchor"
    bindToController: true
    template: """
      <div class="th-modal-backdrop" ng-class="{visible: anchor.modals.length > 0}">
        <div class="th-modal-container" ng-repeat="modal in anchor.modals | limitTo:1">
          <div class="cell">
            <th-modal modal-data="modal"></th-modal>
          </div>
        </div>
      </div>
    """
    controller: (ModalManager) ->
      @modals = ModalManager._modals

      return

