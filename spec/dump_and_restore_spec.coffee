_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai           = require('chai')
sinon          = require('sinon')
sinonChai      = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Dump and restore', ->

  e = null

  beforeEach ->
    e = Echo()


  describe '#dump()', ->

    it 'should be defined', ->
      e.dump.should.exist

    it 'should be function', ->
      e.dump.should.be.a 'function'

    it 'should dump logs into JSON', ->
      e('trololo')
      e('qwerty')
      e.dump().should.be.a 'string'
      restored = JSON.parse(e.dump())
      restored.should.be.a 'array'
      restored[0].body[0].should.eq 'trololo'
      restored[1].body[0].should.eq 'qwerty'


  describe '#restore()', ->

    it 'should be defined'

    it 'should be function'

    it 'should restore logs from dump'

  describe 'restore on initialization', ->

    it 'should restore log on initialization'
