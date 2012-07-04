echo      = require('../src/echo.coffee')

chai      = require('chai')
sinon     = require('sinon')
sinonChai = require('sinon-chai')

chai.should()
chai.use(sinonChai)

describe 'echo', ->

  it 'should be defined', ->
    echo.should.exist