describe 'ThemisComponents: Directive: thButton', ->
  element = compile = scope = httpBackend = null

  validTemplate = '<div th-button ng-click="action()" text="js"></div>'
  disabledTemplate = '<div th-button ng-click="action()" text="js" disabled></div>'
  submitTemplate = '<div th-button type="submit" text="href"></div>'
  hrefTemplate = '<div th-button href="https://example.com" text="href"></div>'

  window =
    location:
      replace: (value) ->
        true

  compileDirective = (template) ->
    template = template ? validTemplate
    element = compile(template)(scope)
    scope.$digest()
    return element

  beforeEach ->
    module 'ThemisComponents'

  beforeEach ->
    inject ($rootScope, $compile) ->
      scope = $rootScope.$new()
      scope.text = 'correct'
      compile = $compile
      $window = window

  beforeEach ->
    element = compileDirective(validTemplate)

  it 'has the button text set correctly', ->
    expect(element.text().trim()).toBe 'js'

  it 'one way binds the text attribute', ->
    isolateScope = element.isolateScope()
    isolateScope.text = 'wrong'
    expect(scope.text).toBe 'correct'

  it 'no longer has the text attribute', ->
    expect(element[0].hasAttribute('text')).toBe false

  it 'has a default type of button', ->
    expect(element.attr('type')).toBe 'button'

  it 'creates the correct DOM element', ->
    buttonElement = element.find('button')
    expect(buttonElement).toBeDefined()

  it 'replaces the directive element', ->
    expect(element.find('th-button').length).toEqual 0

  describe 'and the button is disabled', ->
    beforeEach ->
      element = compileDirective(disabledTemplate)

    it 'has the disabled attribute', ->
      expect(element[0].hasAttribute('disabled')).toBe true

  describe 'is a submit button', ->
    beforeEach ->
      element = compileDirective(submitTemplate)

    it 'has type of submit', ->
      expect(element.attr('type')).toBe 'submit'
