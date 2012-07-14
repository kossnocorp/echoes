_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai           = require('chai')
sinon          = require('sinon')
sinonChai      = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Search logs', ->

  e = null

  beforeEach ->
    e = Echo()


  describe 'logs object', ->

    it 'should be defined', ->
      e.logs.should.exist

    it 'should be object', ->
      e.logs.should.be.a 'object'


  describe '#first()', ->

    it 'should be defined', ->
      e.logs.first.should.exist

    it 'should be function', ->
      e.logs.first.should.be.a 'function'

    it 'should return first log', ->
      e('test1')
      e('test2')
      logs = e.logs.first()
      logs.body[0].should.eq 'test1'


  describe '#all()', ->

    it 'should be defined', ->
      e.logs.all.should.exist

    it 'should be function', ->
      e.logs.all.should.be.a 'function'

    it 'should returns all logs', ->
      e('test1')
      e('test2')
      allLogs = e.logs.all()
      allLogs.should.be.an 'array'
      allLogs[0].body[0].should.eq 'test1'
      allLogs[1].body[0].should.eq 'test2'


  describe '#grep()', ->

    it 'should be defined'

    it 'should be function'

    it 'should returns array'

    it 'should grep string in logs'
