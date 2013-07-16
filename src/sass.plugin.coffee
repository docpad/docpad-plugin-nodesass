# Export Plugin
module.exports = (BasePlugin) ->
  # Requires
  safeps = require('safeps')
  fs = require('fs')
  {TaskGroup} = require('taskgroup')
  sass = require('node-sass')

  # Define Plugin
  class SassPlugin extends BasePlugin
    # Plugin name
    name: 'sass'

    # Plugin config
    # Only on the development environment use expanded, otherwise use compressed
    config:
      debugInfo: false
      # sourcemaps are not currently supported by libsass
      #sourcemap: false
      # outputStyle is not currently supported by libsass
      #outputStyle: 'compressed'
      renderUnderscoreStylesheets: false
      environments:
        development:
          debugInfo: 'normal'

    # Generate Before
    generateBefore: (opts,next) ->
      # Prepare
      config = @config

      # Group
      tasks = new TaskGroup().setConfig(concurrency:0).once('complete',next)

      # Fire tasks
      tasks.run()

    # Prevent underscore
    extendCollections: (opts) ->
      # Prepare
      config = @config
      docpad = @docpad

      # Prevent underscore files from being written if desired
      if config.renderUnderscoreStylesheets is false
        @underscoreStylesheets = docpad.getDatabase().findAllLive(filename: /^_(.*?)\.(?:scss|sass)/)
        @underscoreStylesheets.on 'add', (model) ->
          model.set({
            render: false
            write: false
          })

    # Render some content
    render: (opts,next) ->
      # Prepare
      config = @config
      {inExtension,outExtension,file} = opts

      # If SASS/SCSS then render
      if inExtension in ['sass','scss'] and outExtension in ['css',null]
        # Fetch useful paths
        fullDirPath = file.get('fullDirPath')

        # Define callback fn
        callback = (css) ->
          opts.content = css
          return next()

        # Prepare the command and options
        commandOpts =
          success: callback
          error: (err)->
            return next(new Error(err))

        if fullDirPath
          commandOpts.includePaths = [fullDirPath]
        if config.debugInfo
          commandOpts.sourceComments = config.debugInfo
          commandOpts.file = file.attributes.fullPath
        else
          commandOpts.data = opts.content
        # outputStyle is not currently supported by libsass
        #if config.outputStyle
          #commandOpts.outputStyle = config.outputStyle

        # Spawn the appropriate process to render the content
        sass.render commandOpts

      else
        # Done, return back to DocPad
        return next()