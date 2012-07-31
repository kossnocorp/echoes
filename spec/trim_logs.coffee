_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai           = require('chai')
sinon          = require('sinon')
sinonChai      = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Trim logs', ->

  e = null

  beforeEach ->
    e = Echo()


  describe 'defineTrim', ->

    it 'should be defined', ->
      e.defineTrim.should.exist

    it 'should be function', ->
      e.defineTrim.should.be.a 'function'


  describe 'by count', ->

    it 'should keep specific count of logs'


  describe 'by timer', ->

    it 'should trim logs for last 10 minutes'


  describe 'level rules', ->

    describe 'except rule', ->

      it 'should allow to set exceptions for specific level'

      it 'should allow to pass number'

      it 'should allow to pass string'

      it 'should allow to pass array of levels'
