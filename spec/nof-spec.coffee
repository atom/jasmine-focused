fs = require 'fs'
path = require 'path'
temp = require 'temp'
nof = require '../lib/nof'

describe "nof", ->
  it "unfocuses all specs in CoffeeScript files", ->
    focused = """
      describe 'specs', ->
        fit 'works', ->
          expect(1).toBe 1

        ffit 'works', ->
          expect(2).toBe 2

        fffit 'works', ->
          expect(2).toBe 2

      fdescribe 'more specs', ->
        ffdescribe 'even more', ->
          fffdescribe 'even more', ->
            it 'works', ->
              expect(0).toBe 0
    """

    specsDirectory = temp.mkdirSync('jasmine-focused-spec-')
    specPath = path.join(specsDirectory, 'a-spec.coffee')
    fs.writeFileSync(specPath, focused)
    nof(specsDirectory)

    expect(fs.readFileSync(specPath, 'utf8')).toBe """
      describe 'specs', ->
        it 'works', ->
          expect(1).toBe 1

        it 'works', ->
          expect(2).toBe 2

        it 'works', ->
          expect(2).toBe 2

      describe 'more specs', ->
        describe 'even more', ->
          describe 'even more', ->
            it 'works', ->
              expect(0).toBe 0
    """

  it "unfocuses all specs in JavaScript files", ->
    focused = """
      describe('specs', function() {
        fit('works', function() {
          expect(1).toBe(1)
        });
      });

      fdescribe('more specs', function() {
        ffdescribe('even more', function() {
          fffdescribe('even more', function() {
            it('works', function() {
              expect(0).toBe(0)
            });
          });
        });
      });
    """

    specsDirectory = temp.mkdirSync('jasmine-focused-spec-')
    specPath = path.join(specsDirectory, 'a-spec.js')
    fs.writeFileSync(specPath, focused)
    nof(specsDirectory)

    expect(fs.readFileSync(specPath, 'utf8')).toBe  """
      describe('specs', function() {
        it('works', function() {
          expect(1).toBe(1)
        });
      });

      describe('more specs', function() {
        describe('even more', function() {
          describe('even more', function() {
            it('works', function() {
              expect(0).toBe(0)
            });
          });
        });
      });
    """
