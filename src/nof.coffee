path = require 'path'
replace = require 'replace'
_ = require 'underscore-plus'

module.exports = (paths...) ->
  paths = _.flatten(paths)
  paths = ['spec'] if paths.length is 0
  paths = paths.map (directory) -> path.resolve(process.cwd(), directory)

  replace
    regex: '^(\\s*)f+(it|describe)((\\s+)|(\\s*\\())'
    replacement: '$1$2$3'
    include: '*.coffee,*.js'
    paths: paths
    recursive: true
    silent: true
    multiline: true
