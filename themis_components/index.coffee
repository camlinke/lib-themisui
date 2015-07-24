angular = require 'angular'

angular.module 'ThemisComponents', [
  require 'angular-animate'
]

require './thBindMarkdown/'
require './thCheckbox/'
require './thCompile/'
require './thComponentExample/'
require './thContextualMessage/'
require './thLazy/'
require './thModal/'
require './thPopover/'
require './thSwitch/'
require './thTabset/'

module.exports = 'ThemisComponents'
