_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai           = require('chai')
sinon          = require('sinon')
sinonChai      = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Defaults', ->

  e = null

  beforeEach ->
    e = Echo()


  describe '#defaultOptions', ->

    it 'should be defined', ->
      e.defaultOptions.should.exist

    it 'should be object', ->
      e.defaultOptions.should.be.a 'object'

    it 'should containt default options', ->
      e.defaultOptions.clone.should.eq           true
      e.defaultOptions.print.should.eq           false
      e.defaultOptions.level.should.eq           0
      e.defaultOptions.namespacePrefix.should.eq ''
      e.defaultOptions.namespace.should.eq       ''
      e.defaultOptions.id.should.eq              ''

    it 'should apply default options to each log', ->
      e('test1')
      log = e.logs.first()
      log.level.should.eq e.defaultOptions.level
      log.cid.should.eq ''


  describe '#defineDefaults()', ->

    it 'should be defined', ->
      e.defineDefaults.should.exist

    it 'should be function', ->
      e.defineDefaults.should.be.a 'function'

    it 'should add defaults to logger', ->
      _(e.debug).isUndefined().should.eq true
      _(e.info).isUndefined().should.eq true
      _(e.warn).isUndefined().should.eq true
      _(e.error).isUndefined().should.eq true
      e.defineDefaults()
      e.debug.should.exist
      e.info.should.exist
      e.warn.should.exist
      e.error.should.exist


  describe 'echo()', ->

    it 'should be defined', ->
      echo.should.exist

    it 'should predefine default levels', ->
      echo.debug.should.exist
      echo.info.should.exist
      echo.warn.should.exist
      echo.error.should.exist
