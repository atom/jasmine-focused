path = require 'path'
replace = require 'replace'

module.exports = ->
  if process.argv.length > 2
    paths = process.argv[2..]
  else
    paths = ['spec']

  paths = paths.map (directory) -> path.resolve(process.cwd(), directory)

  replace
    regex: '(^\\s*)f+(it|describe)(\\s+)',
    replacement: '$1$2$3'
    include: '*.js,*.coffee'
    paths: paths
    recursive: true
    silent: true
