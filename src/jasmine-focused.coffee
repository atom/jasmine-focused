jasmine = require 'jasmine-node'

setGlobalFocusPriority = (priority) ->
  env = jasmine.getEnv()
  env.focusPriority = 1 unless env.focusPriority
  env.focusPriority = priority if priority > env.focusPriority

focusMethods =
  fdescribe: (description, specDefinitions, priority=1) ->
    setGlobalFocusPriority(priority)
    suite = describe(description, specDefinitions)
    suite.focusPriority = priority
    suite

  ffdescribe: (description, specDefinitions) ->
    @fdescribe(description, specDefinitions, 2)

  fffdescribe: (description, specDefinitions) ->
    @fdescribe(description, specDefinitions, 3)

  fit: (description, definition, priority=1) ->
    setGlobalFocusPriority(priority)
    spec = it(description, definition)
    spec.focusPriority = priority
    spec

  ffit: (description, specDefinitions) ->
    @fit(description, specDefinitions, 2)

  fffit: (description, specDefinitions) ->
    @fit(description, specDefinitions, 3)

globals  = []
globals.push(global) if global?
globals.push(window) if window?
for methodName, methodBody of focusMethods
  object[methodName] = methodBody for object in globals

jasmine.getEnv().specFilter = (spec) ->
  env = jasmine.getEnv()
  globalFocusPriority = env.focusPriority
  parent = spec.parentSuite ? spec.suite

  if not globalFocusPriority
    true
  else if spec.focusPriority >= globalFocusPriority
    true
  else if not parent
    false
  else
    env.specFilter(parent)

module.exports = jasmine
