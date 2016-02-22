moment = require("moment")

angular.module('ThemisComponents')
  .directive 'thDatePicker', ->
    restrict: "E"
    template: """
<th-input
  ng-model="datepicker.inputDate"
  type="text"
  placeholder="YYYY-MM-DD"
  icon="calendar"
  ></th-input>
    """
    scope:
      date: "=ngModel"
      dateFormat: "@"
    bindToController: true
    controllerAs: 'datepicker'
    controller: ($element, $scope, $filter) ->
      # @dateFormat ?= 'YYYY-MM-DD'
      # @date ?= moment()
      @inputDate = ""
      # @unregisterDateWatcher = null

      # $scope.$watch 'datepicker.inputDate', =>
      #   parsedDate = moment(@inputDate, @dateFormat)
      #   if parsedDate.isValid()
      #     @date = parsedDate

      # @registerDateWatcher = =>
      #   @unregisterDateWatcher() if @unregisterDateWatcher?
      #   @unregisterDateWatcher = $scope.$watch 'datepicker.date', ->
      #     setInputDate()

      # setInputDate = =>
      #   @inputDate = @date.format(@dateFormat)

      # @registerDateWatcher()

      # dateInputField = $element.find('input')
      
      # dateInputField.on 'blur', => $scope.$apply =>
      #   @registerDateWatcher()
      #   setInputDate()

      # dateInputField.on 'focus', => $scope.$apply =>
      #   @unregisterDateWatcher()

      return
