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
    config:
      bourbon: false
      debugInfo: false
      #imagePath:
      neat: false
      #outputStyle: 'compressed'
      precision: 5
      renderUnderscoreStylesheets: false
      sourceMap: false
      includePaths: []

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
      paths = []

      {inExtension,outExtension,file} = opts

      # If SASS/SCSS then render
      if inExtension in ['sass', 'scss'] and outExtension in ['css',null]
        # Fetch useful paths
        fullDirPath = file.get('fullDirPath')

        # Read sources & return content
        getSourcesContent = (sources) ->
          sourcesContent = []
          i = 0

          while i < sources.length
            source = fullDirPath + '/' + sources[i]
            sourcesContent[i] = fs.readFileSync(source,
              encoding: 'utf8'
            )
            i++
          sourcesContent

        # Define callback fn
        callback = (css, map) ->
          if map
            map = JSON.parse(map)
            map.sourcesContent = getSourcesContent(map.sources);
            sourceMap = new Buffer(JSON.stringify(map)).toString('base64');
            css = css.replace(/\/\*# sourceMappingURL=.*\*\//, '/*# sourceMappingURL=data:application/json;base64,' + sourceMap + '*/')

          opts.content = css
          return next()

        # Prepare the command and options
        cmdOpts =
          success: callback
          error: (err)->
            return next(new Error(err))

        if fullDirPath
          paths.push(fullDirPath)

          if config.bourbon
            for path in bourbon
              paths.push(path)
          if config.neat
            for path in neat
              paths.push(path)

        cmdOpts.includePaths = config.includePaths.concat(paths)
        cmdOpts.precision = config.precision

        if config.debugInfo and config.debugInfo isnt 'none'
          cmdOpts.sourceComments = config.debugInfo
          cmdOpts.file = file.attributes.fullPath
        else
          cmdOpts.data = opts.content

        if config.imagePath
          cmdOpts.imagePath = config.imagePath

        if config.outputStyle
          cmdOpts.outputStyle = config.outputStyle

        if config.sourceMap
          cmdOpts.sourceMap = config.sourceMap

        # Spawn the appropriate process to render the content
        sass.render cmdOpts

      else
        # Done, return back to DocPad
        return next()
