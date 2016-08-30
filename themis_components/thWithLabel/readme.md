# Input — `with-label`

## Description

Wrap your input fields in a styled label easily by adding this `with-label` component to it.

`<th-input with-label="My Label Name" ng-model="myModel"></th-input>`

- It can only be used as an attribute to an existing input element.
- By default the label prepended is to the input field which means that it will show up above the element.
- Labels for input types `checkbox`, `switch` and `radio` are set inline.
- It can be used with any HTML element if one were so inclined but it is really recommended for use with input elements.
- `with-label` works well with themisUi components:
  - thSelect
  - thInput
  - thCheckbox
  - thSwitch
- Using the `ng-required` attribute with any input element will add a "required" indicator.

---
