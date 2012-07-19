_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai           = require('chai')
sinon          = require('sinon')
sinonChai      = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Dump and restore', ->

  deepObject =
    origin:
      a:
        b:
          c: 1
          d:
            e:
              f: [2, 3]
              g: 4
      h: 5
    1:
      a: '[object]'
      h: 5
    2:
      a:
        b: '[object]'
      h: 5
    3:
      a:
        b:
          c: 1
          d: '[object]'
      h: 5
    4:
      a:
        b:
          c: 1
          d:
            e: '[object]'
      h: 5
    5:
      a:
        b:
          c: 1
          d:
            e:
              f: '[array]'
              g: 4
      h: 5

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

    it 'should dump with passed deep level (by default is 1)', ->
      e(deepObject.origin)
      JSON.parse(e.dump())[0].body[0].should.be.deep.eql deepObject[1]
      JSON.parse(e.dump(1))[0].body[0].should.be.deep.eql deepObject[1]
      JSON.parse(e.dump(2))[0].body[0].should.be.deep.eql deepObject[2]
      JSON.parse(e.dump(3))[0].body[0].should.be.deep.eql deepObject[3]
      JSON.parse(e.dump(4))[0].body[0].should.be.deep.eql deepObject[4]
      JSON.parse(e.dump(5))[0].body[0].should.be.deep.eql deepObject[5]
      JSON.parse(e.dump(6))[0].body[0].should.be.deep.eql deepObject.origin
      JSON.parse(e.dump(7))[0].body[0].should.be.deep.eql deepObject.origin


  describe '#restore()', ->

    it 'should be defined', ->
      e.restore.should.exist

    it 'should be function', ->
      e.restore.should.be.a 'function'

    it 'should restore logs from dump', ->
      eh = Echo()
      eh('Hello')
      eh('There')
      eh('!')
      e.restore(eh.dump())
      allLogs = e.logs.all()
      allLogs[0].body[0].should.eq 'Hello'
      allLogs[1].body[0].should.eq 'There'
      allLogs[2].body[0].should.eq '!'


  describe 'restore on initialization', ->

    it 'should restore log on initialization', ->
      e('Hello')
      e('There')
      e('!')
      eh = Echo(e.dump())
      allLogs = eh.logs.all()
      allLogs[0].body[0].should.eq 'Hello'
      allLogs[1].body[0].should.eq 'There'
      allLogs[2].body[0].should.eq '!'
