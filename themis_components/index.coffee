require '../public/javascript/prism.js'
require '../polyfills/'

angular.module 'ThemisComponents', [
  require 'angular-animate'
  require './thDatePicker/angularjs-datepicker'
]

require './thAlert/'
require './thBindMarkdown/'
require './thButton/'
require './thCheckbox/'
require './thCompile/'
require './thComponentExample/'
require './thContentHeader/'
require './thContextualMessage/'
require './thDisclosure/'
require './thDatePicker/'
require './thDropdown/'
require './thError/'
require './thInput/'
require './thLazy/'
require './thLoader/'
require './thModal/'
require './thPopover/'
require './thRadioGroup/'
require './thSelect/'
require './thSwitch/'
require './thTable/'
require './thTabset/'
require './thWithFocus/'
require './thWithLabel/'

module.exports = 'ThemisComponents'
