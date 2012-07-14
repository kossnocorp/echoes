_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai           = require('chai')
sinon          = require('sinon')
sinonChai      = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Define new log functions', ->

  e = null

  beforeEach ->
    e = Echo()


  describe '#curry()', ->

    it 'should be defined', ->
      e.curry.should.exist

    it 'should return function', ->
      e.curry().should.be.a 'function'

    it 'should return carried function', ->
      fn = e.curry(level: 5, namespace: 'qwe')
      fn('LOL')
      log1 = e.logs.first()
      log1.body[0].should.eq 'LOL'
      log1.level.should.eq 5
      log1.cid.should.eq 'qwe'
      fn('w00t', namespace: 'asd')
      log2 = e.logs.all()[1]
      log2.body[0].should.eq 'w00t'
      log2.level.should.eq 5
      log2.cid.should.eq 'asd'

    it 'should allow to pass body', ->
      fn = e.curry('LOL', level: 5)
      fn()
      log1 = e.logs.first()
      log1.body[0].should.eq 'LOL'
      log1.level.should.eq 5

      fn('w00t', namespace: 'asd')
      log2 = e.logs.all()[1]
      log2.body[0].should.eq 'LOL'
      log2.body[1].should.eq 'w00t'
      log2.cid.should.eq 'asd'

      fn2 = e.curry(1, 2, 3, 4, level: 9)
      fn2('trololo', level: 6)
      log3 = e.logs.all()[2]

      log3.body[0].should.eq 1
      log3.body[1].should.eq 2
      log3.body[2].should.eq 3
      log3.body[3].should.eq 4
      log3.body[4].should.eq 'trololo'
      log3.level.should.eq 6


  describe '#define()', ->

    it 'should be defined', ->
      e.define.should.exist

    it 'should be function', ->
      e.define.should.be.a 'function'

    it 'should add new function to echo', ->
      e.define('info', 1)
      e.info.should.exist
      e.info.should.be.a 'function'
      e.define(warn: 2, error: 3)
      e.warn.exist
      e.warn.should.be.a 'function'
      e.error.should.exist
      e.error.should.be.a 'function'

    it 'should return curried function with defined level', ->
      e.define('info', 1)
      e.info('w00t', namespace: 'qwerty')
      log = e.logs.first()
      log.body[0].should.eq 'w00t'
      log.level.should.eq 1
      log.cid.should.eq 'qwerty'
