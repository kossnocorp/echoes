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

    it 'should keep specific count of logs', ->
      e.defineTrim(count: 2)
      e(1)
      e(2)
      e(3)
      e(4)
      e(5)
      allLogs = e.logs.all()
      allLogs.length.should.be.eq 2
      allLogs[0].body[0].should.eq 4
      allLogs[1].body[0].should.eq 5


  describe 'by timer', ->

    it 'should trim logs for last 10 minutes', ->
      clock = sinon.useFakeTimers()

      e(1)

      clock.tick(1000 * 60 * 5) # 5 min later
      allLogs = e.logs.all()
      allLogs.length.should.eq 1
      allLogs[0].body[0].should.eq 1
      e(2)

      clock.tick(1000 * 60 * 6) # 6 min later (11 minutes since start)
      allLogs = e.logs.all()
      allLogs.length.should.eq 1
      allLogs[0].body[0].should.eq 2
      e(3)

      clock.tick(1000 * 60 * 9) # 9 min later (20 minutes since start)
      allLogs = e.logs.all()
      allLogs.length.should.eq 1
      allLogs[0].body[0].should.eq 3

      clock.tick(1000 * 60 * 2) # 2 min later (22 minutes since start)
      e.logs.all().length.should.eq 0

      clock.restore()


  describe 'level rules', ->

    describe 'except rule', ->

      it 'should allow to set exceptions for specific level', ->
        e.defineTrim(count: 2, except: 2)
        e(1, level: 2)
        e(2)
        e(3)
        e(4)
        e(5)
        allLogs = e.logs.all()
        allLogs.length.should.be.eq 3
        allLogs[0].body[0].should.eq 1
        allLogs[1].body[0].should.eq 4
        allLogs[2].body[0].should.eq 5

      it 'should allow to pass string', ->
        e.define(test: 2)
        e.defineTrim(count: 2, except: 'test')
        e(1, level: 'test')
        e(2)
        e(3)
        e(4)
        e(5)
        allLogs = e.logs.all()
        allLogs.length.should.be.eq 3
        allLogs[0].body[0].should.eq 1
        allLogs[1].body[0].should.eq 4
        allLogs[2].body[0].should.eq 5

      it 'should allow to pass array of levels', ->
        e.define(test: 2)
        e.defineTrim(count: 2, except: [3, 'test'])
        e(1, level: 'test')
        e(2, level: 3)
        e(3)
        e(4)
        e(5)
        allLogs = e.logs.all()
        allLogs.length.should.be.eq 4
        allLogs[0].body[0].should.eq 1
        allLogs[1].body[0].should.eq 2
        allLogs[2].body[0].should.eq 4
        allLogs[3].body[0].should.eq 5
