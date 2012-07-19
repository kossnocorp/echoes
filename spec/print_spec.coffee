_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai           = require('chai')
sinon          = require('sinon')
sinonChai      = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Print logs to console', ->

  e = null

  beforeEach ->
    e = Echo()


  describe 'print: true', ->

    it "should print with console.log if it's defined", ->
      sinon.spy(console, 'log')
      e('Hello there!', print: true)
      console.log.should.have.been.calledWith('Hello there!')
      e('Hello', 'there!', print: true)
      console.log.should.have.been.calledWith('Hello', 'there!')
      console.log.restore()

    it "should print with console.info if it's defined, level is 1 and defineDefaults is called", ->

    it "should print with console.warn if it's defined, level is 2 and defineDefaults is called"

    it "should print with console.error if it's defined, level is 3 and defineDefaults is called"


  describe 'definePrint', ->

    it 'should be defined'

    it 'should be a function'

    it 'should define print value for specific levels'

    it 'should accept options as pair of strings and as object'


  describe 'setPrintFunction', ->

    it 'should be defined'

    it 'should be a function'

    it 'should set passed function as function for print'
