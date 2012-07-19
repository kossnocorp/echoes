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

    it 'should be defined', ->
      e.definePrint.should.exists

    it 'should be a function', ->
      e.definePrint.should.be.a 'function'

    it 'should define print value for specific levels', ->
      e.definePrint(3, true)
      sinon.spy(console, 'log')
      e('Hello there!', print: true)
      console.log.should.have.been.calledWith('Hello there!')
      console.log.restore()

    it 'should accept options as pair of strings and as object'

    it 'should set print true by default in `all: true` passed'

    it 'should set print true for specific levels with `only` key passed'

    it 'should set print true for all but specific levels with `except` key passed'

    it 'should set print true for all levels greater than x with greaterThan (gt) key passed'

    it 'should set print true for all levels greater than or equal to x with greaterThanOrEqualTo (gte, gteq) key passed'

    it 'should set print true for all levels less than x with lessThan (lt) key passed'

    it 'should set print true for all levels less than or equal to x with lessThanOrEqualTo (lte, lteq) key passed'

    it 'should properly process mix of all, only, except, lt, gt, lte, gte keys'


  describe 'setPrintFunction', ->

    it 'should be defined'

    it 'should be a function'

    it 'should set passed function as function for print'
