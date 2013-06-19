path = require 'path'
replace = require 'replace'
_ = require 'underscore'

module.exports = (paths...) ->
  paths = _.flatten(paths)
  paths = ['spec'] if paths.length is 0
  paths = paths.map (directory) -> path.resolve(process.cwd(), directory)

  replace
    regex: '^(\\s*)f+(it|describe)(\\s+)'
    replacement: '$1$2$3'
    include: '*.coffee'
    paths: paths
    recursive: true
    silent: true
    multiline: true
