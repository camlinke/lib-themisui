angular.module('ThemisComponents')
  .directive "thPopover", (PopoverManager) ->
    restrict: "A"
    scope: true
    link: ($scope, element, attributes) ->
      getContent = (success, failure) ->
        content = PopoverManager.getContent attributes.thPopover
        if content?.length > 0 then success(content) else failure()

      PopoverManager.addTarget($scope, element, attributes, getContent)
