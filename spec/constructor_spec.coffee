_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai           = require('chai')
sinon          = require('sinon')
sinonChai      = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Constructor', ->

  it 'should be defined', ->
    Echo.should.exist

  it 'should be function', ->
    Echo.should.be.a 'function'

  it 'should returns function', ->
    Echo().should.be.a 'function'
