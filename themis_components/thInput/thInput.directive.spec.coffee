context = describe

describe 'thInput', ->
  element = null

  context 'with complete example', ->
    beforeEach ->
      element = compileDirective("""
        <th-input type="text"
                  name="nickname"
                  value="Steve-o"
                  placeholder="Enter your nickname">
        </th-input>
      """).element

    it "removes the icon element when the icon attribute is not specified", ->
      expect(element.find("i").length).toBe 0

    it "removes the prefix element when the prefix attribute is not specified", ->
      expect(element.find(".th-input-prefix").length).toBe 0
      expect(element.find("input").hasClass("with-prefix")).toBe false

    it "removes the postfix element when the postfix attribute is not specified", ->
      expect(element.find(".th-input-postfix").length).toBe 0
      expect(element.find("input").hasClass("with-postfix")).toBe false

    it "gains class 'has-focus' when input is in focus", ->
      element.find("input").triggerHandler 'focus'
      expect(element.hasClass("has-focus")).toBe true

    it "loses class 'has-focus' when input loses focus", ->
      element.find("input").triggerHandler 'focus'
      expect(element.hasClass("has-focus")).toBe true
      element.find("input").triggerHandler 'blur'
      expect(element.hasClass("has-focus")).toBe false

    describe 'input', ->
      it 'has appropriate attributes set', ->
        input = element.find("input").first()

        expect(input.attr("type")).toBe 'text'
        expect(input.attr("name")).toBe 'nickname'
        expect(input.attr("value")).toBe 'Steve-o'
        expect(input.attr("placeholder")).toBe 'Enter your nickname'

  ["text", "password"].forEach (type) ->
    it "supports #{type}", ->
      element = compileDirective("<th-input type='#{type}'></th-input>").element
      expect(element.find("input").attr("type")).toBe type

  context "with icon", ->
    beforeEach ->
      element = compileDirective("""
        <th-input type="text" icon="user"></th-input>
      """).element

    it "adds an icon with the specified icon class", ->
      expect(element.find("i").hasClass("fa-user")).toBeTruthy()

    it "adds with-icon to the input field", ->
      expect(element.find("input").hasClass("with-icon")).toBeTruthy()

  context "with prefix", ->
    beforeEach ->
      element = compileDirective("""
        <th-input type="text" prefix="$"></th-input>
      """).element

    it "adds .with-prefix to <input>", ->
      expect(element.find("input").hasClass("with-prefix")).toBeTruthy()

    it "displays $ before input", ->
      inputWrapper = element.find(".th-input-wrapper")
      expect(inputWrapper.first().text()).toMatch "$"

  context "with postfix", ->
    beforeEach ->
      element = compileDirective("""
        <th-input type="text" postfix="/hr"></th-input>
      """).element

    it "adds .with-postfix to <input>", ->
      expect(element.find("input").hasClass("with-postfix")).toBeTruthy()

    it "displays '/hr' before input", ->
      postfix = element.find(".th-input-postfix")
      expect(postfix.text()).toMatch "/hr"

  context "with validations", ->
    beforeEach ->
      scopeAdditions =
        pattern: /^[a-zA-Z ]*$/
      {element} = compileDirective("""
        <th-input
          ng-required="true"
          ng-minLength="10"
          ng-maxLength="20"
          ng-pattern="pattern">
        </th-input>""", scopeAdditions)

    describe "textarea", ->
      it "has all ng-requirements added", ->
        input = element.find("input")[0]
        expect(input.hasAttribute("ng-required")).toBe true
        expect(input.hasAttribute("required")).toBe true
        expect(input.hasAttribute("ng-minLength")).toBe true
        expect(input.hasAttribute("ng-maxLength")).toBe true
        expect(input.hasAttribute("ng-pattern")).toBe true
        expect(input.getAttribute("ng-pattern")).toEqual '/^[a-zA-Z ]*$/'
        expect(input.getAttribute("ng-minLength")).toEqual '10'
        expect(input.getAttribute("ng-maxLength")).toEqual '20'
        expect(input.getAttribute("ng-pattern")).toEqual '/^[a-zA-Z ]*$/'

    context "with ng-disabled evaluating to true", ->
      beforeEach ->
        {element} = compileDirective(
          """<th-input ng-disabled="true"></th-input>""")

      describe "the input", ->
        it "is disabled", ->
          expect(element.find("input").attr("disabled")).toEqual "disabled"
          expect(element.find("input").hasClass("disabled")).toBe true

