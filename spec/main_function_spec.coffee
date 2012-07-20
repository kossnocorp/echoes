_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai           = require('chai')
sinon          = require('sinon')
sinonChai      = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Main log function', ->

  e = null

  beforeEach ->
    e = Echo()


  it 'should log strings', ->
    e('test')
    log = e.logs.first()
    log.should.be.a 'object'
    log.body.should.be.an('array')
    log.body[0].should.eq 'test'

  it 'should save passed options', ->
    e('test', level: 4, namespace: 'qwerty')
    log = e.logs.first()
    log.cid.should.eq 'qwerty'
    log.level.should.eq 4

  it 'should not save options to body', ->
    e('test', level: 4, namespace: 'qwerty')
    log = e.logs.first()
    _(log.body[1]).isUndefined().should.eq true

  it 'should add timestamp to log', ->
    e('test')
    log = e.logs.first()
    log.timestamp.should.exist
    log.timestamp.should.be.a 'number'
    log.timestamp.toString().length.should.eq 13

  it 'should accept string levels', ->
    e.define('trash', 3)
    e('Trololo', level: 'trash')
    e('Trololo', level: 'lol')
    allLogs = e.logs.all()
    allLogs[0].level.should.eq 3
    allLogs[1].level.should.eq 0

  it 'should join namespacePrefix and id and save as cid', ->
    e(namespacePrefix: 'app', id: 42)
    e.logs.first().cid.should.eq 'app.42'

  it 'should join namespace and id and save as cid', ->
    e(namespace: 'test', id: 42)
    e.logs.first().cid.should.eq 'test.42'

  it 'should join namespacePrefix and namespace and save as cid', ->
    e(namespacePrefix: 'app', namespace: 'test')
    e.logs.first().cid.should.eq 'app.test'

  it 'should join namespacePrefix, namespace and id and save as cid', ->
    e(namespacePrefix: 'app', namespace: 'test', id: 42)
    e.logs.first().cid.should.eq 'app.test.42'

  it 'should filter options saved to log', ->
    e \
      1,
      clone: true
      level: 'trololo'
      namespacePrefix: 'app'
      namespace: 'test'
      id: 42

    log = e.logs.first()

    logExample =
      body:      [1]
      level:     0
      cid:       'app.test.42'
      timestamp: log.timestamp

    log.should.be.eql logExample

