_              = require('underscore')
{ Echo, echo } = require('../src/echo.coffee')

chai           = require('chai')
sinon          = require('sinon')
sinonChai      = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'Clone objects and arrays', ->

  e = null

  beforeEach ->
    e = Echo()


  it 'should clone objects on log (but not deeply)', ->
    obj =
      qwe: 1
      asd: 2
      obj: qwe: 1, asd: 2
    e(obj)
    e.logs.first().body[0].should.not.equal obj
    e.logs.first().body[0].obj.should.equal obj.obj

  it 'should clone arrays on log (but not deeply)', ->
    array = [[1, 2], 3, 4]
    e(array)
    e.logs.first().body[0].should.not.equal array
    e.logs.first().body[0][0].should.equal array[0]
