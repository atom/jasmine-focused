fs = require 'fs'
path = require 'path'
_ = require 'underscore-plus'
walkdir = require 'walkdir'

module.exports = (specPaths...) ->
  specPaths = _.flatten(specPaths)
  specPaths = ['spec'] if specPaths.length is 0
  specPaths = specPaths.map (directory) -> path.resolve(directory)

  pattern = /^(\s*)f+(it|describe)((\s+)|(\s*\())/gm

  for specDirectory in specPaths
    try
      continue unless fs.statSync(specDirectory).isDirectory()
    catch error
      continue

    for specPath in walkdir.sync(specDirectory)
      try
        stats = fs.statSync(specPath)
        continue unless stats.isFile()
        continue if stats.size is 0
      catch error
        continue


      continue unless path.extname(specPath) in ['.coffee', '.js']

      specContents = fs.readFileSync(specPath, 'utf8')
      fs.writeFileSync(specPath, specContents.replace(pattern, '$1$2$3'))
