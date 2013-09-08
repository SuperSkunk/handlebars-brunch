handlebars = require 'handlebars'
umd = require 'umd-wrapper'
sysPath = require 'path'
htmlMinifier = require 'html-minifier'

module.exports = class HandlebarsCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'hbs'
  pattern: /\.(?:hbs|handlebars)$/

  constructor: (@config) ->
    null

  compile: (data, path, callback) ->
    try
      data = @compress data
      result = umd "Handlebars.template(#{handlebars.precompile data})"
    catch err
      error = err
    finally
      callback error, result

  compress: (data) ->
    htmlMinifier.minify data,
      removeComments: true
      removeCommentsFromCDATA: true
      removeCDATASectionsFromCDATA: true
      collapseWhitespace: true
      collapseBooleanAttributes: true

  include: [
    (sysPath.join __dirname, '..', 'vendor',
      'handlebars.runtime-1.0.js')
  ]
