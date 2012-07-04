_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai      = require('chai')
sinon     = require('sinon')
sinonChai = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Echo', ->

  it 'should be defined', ->
    Echo.should.exist

  it 'should be function', ->
    Echo.should.be.function

  it 'should returns function', ->
    Echo().should.be.function


  e = null

  beforeEach ->
    e = Echo()


  describe 'main function', ->

    it 'should log strings', ->
      e('test')
      log = e.logs.all()[0]
      log.should.be.object
      log.body.should.be.array
      log.body[0].should == 'test'


  describe '#logs', ->

    it 'should be defined', ->
      e.logs.should.exist

    it 'should be object', ->
      e.logs.should.be.object


    describe '#all()', ->

      it 'should be defined', ->
        e.logs.all.should.exist

      it 'should be function', ->
        e.logs.all.should.be.function

      it 'should returns all logs', ->
        e('test1')
        e('test2')
        allLogs = e.logs.all()
        allLogs[0].body[0].should == 'test1'
        allLogs[1].body[0].should == 'test2'


  describe '#defaultOptions', ->

    it 'should be defined', ->
      e.defaultOptions.should.exist

    it 'should be object', ->
      e.defaultOptions.should.be.object

    it 'should containt default options', ->
      e.defaultOptions.level.should           == 0
      e.defaultOptions.namespace.should       == ''
      e.defaultOptions.namespacePrefix.should == ''

    it 'should apply default options to each log', ->
      e('test1')
      log = e.logs.all()[0]
      log.level.should == e.defaultOptions.level
      namespace = ''
      unless _(e.defaultOptions.namespacePrefix).isEmpty()
        namespace += e.defaultOptions.namespacePrefix + '.'
      namespace += e.defaultOptions.namespace
      log.namespace == namespace


  describe '#curry()', ->

    it 'should be defined', ->
      e.curry.should.exist

    it 'should return function', ->
      e.curry().should.be.function

    it 'should return carried function', ->


  describe '#define()', ->

    it 'should be defined', ->
      e.define.should.exist

    it 'should be function', ->
      e.define.should.be.function

    it 'should add new function to echo'


  describe '#defineDefaults()', ->

    it 'should be defined', ->
      e.defineDefaults.should.exist


  describe 'echo()', ->

    it 'should be defined', ->
      echo.should.exist

    it 'should predefine default levels', ->
      echo.debug.should.exist
      echo.info.should.exist
      echo.warn.should.exist
      echo.error.should.exist