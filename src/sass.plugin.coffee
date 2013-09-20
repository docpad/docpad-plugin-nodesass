# Export Plugin
module.exports = (BasePlugin) ->
  # Requires
  fs = require('fs')
  {TaskGroup} = require('taskgroup')
  sass = require('node-sass')
  bourbon = require('node-bourbon').includePaths
  neat = require('node-neat').includePaths

  # Define Plugin
  class NodesassPlugin extends BasePlugin
    # Plugin name
    name: 'nodesass'

    # Plugin config
    # Only on the development environment use expanded, otherwise use compressed
    config:
      bourbon: false
      debugInfo: false
      # sourcemaps are not currently supported by libsass
      #sourcemap: false
      # outputStyle is not currently supported by libsass
      #outputStyle: 'compressed'
      neat: false
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
        @underscoreStylesheets = docpad.getDatabase().findAllLive(filename: /^_(.*?)\.(?:scss)/)
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

      if config.neat
        config.bourbon = true

      # If SCSS then render
      if inExtension in ['scss'] and outExtension in ['css',null]
        # Fetch useful paths
        fullDirPath = file.get('fullDirPath')

        # Define callback fn
        callback = (css) ->
          opts.content = css
          return next()

        # Prepare the command and options
        cmdOpts =
          success: callback
          error: (err)->
            return next(new Error(err))

        if fullDirPath
          paths = [fullDirPath]

          if config.bourbon
            paths.push(bourbon)
          if config.neat
            paths.push(neat)

          cmdOpts.includePaths = paths

        if config.debugInfo
          cmdOpts.sourceComments = config.debugInfo
          cmdOpts.file = file.attributes.fullPath
        else
          cmdOpts.data = opts.content
        # outputStyle is not currently supported by libsass
        #if config.outputStyle
          #cmdOpts.outputStyle = config.outputStyle

        # Spawn the appropriate process to render the content
        sass.render cmdOpts

      else
        # Done, return back to DocPad
        return next()
