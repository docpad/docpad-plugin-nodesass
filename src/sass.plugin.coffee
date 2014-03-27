# Export Plugin
module.exports = (BasePlugin) ->
  # Requires
  fs = require('fs')
  {TaskGroup} = require('taskgroup')
  sass = require('node-sass')
  bourbon = require('node-bourbon').includePaths
  neat = require('node-neat').includePaths
  mkdirp = require('mkdirp')

  # Define Plugin
  class NodesassPlugin extends BasePlugin
    # Plugin name
    name: 'nodesass'

    # Plugin config
    config:
      bourbon: false
      debugInfo: false
      #outputStyle: 'compressed'
      neat: false
      renderUnderscoreStylesheets: false
      sourceMap: false

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
        callback = (css, map) ->
          if map
            path = file.get('outPath') + '.map'
            fileName = path.split('/').pop()

            # Create dir for sourcemap
            mkdirp file.get('outDirPath'), (err)->
              if err
                console.log err
              else
                # Write sourcemap
                fs.writeFile path, map, (err)->
                  if err
                    console.log err

            # Include sourcemap URL in CSS file
            css = '/*# sourceMappingURL=./' + fileName + ' */\n' + css

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

        if config.debugInfo and config.debugInfo isnt 'none'
          cmdOpts.sourceComments = config.debugInfo
          cmdOpts.file = file.attributes.fullPath
        else
          cmdOpts.data = opts.content

        if config.outputStyle
          cmdOpts.outputStyle = config.outputStyle

        if config.sourceMap
          cmdOpts.sourceMap = config.sourceMap

        # Spawn the appropriate process to render the content
        sass.render cmdOpts

      else
        # Done, return back to DocPad
        return next()
