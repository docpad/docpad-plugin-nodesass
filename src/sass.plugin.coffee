# Export Plugin
module.exports = (BasePlugin) ->
  # Requires
  fs = require('fs')
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
      neat: false
      renderUnderscoreStylesheets: false
      sourceMap: false

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
    render: (opts, next) ->
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

        # Prepare the command and options
        cmdOpts = {}

        for prop of config.options
          cmdOpts[prop] = config.options[prop]

        if fullDirPath
          paths.push(fullDirPath)

          if config.bourbon
            for path in bourbon
              paths.push(path)
          if config.neat
            for path in neat
              paths.push(path)

        cmdOpts.includePaths = if cmdOpts.includePaths then cmdOpts.includePaths.concat(paths) else paths

        if config.debugInfo and config.debugInfo isnt 'none'
          cmdOpts.sourceComments = config.debugInfo
          cmdOpts.file = file.attributes.fullPath
        else
          cmdOpts.data = opts.content

        # Spawn the appropriate process to render the content
        result = sass.renderSync cmdOpts

        css = result.css

        if result.map and result.map.sources
          map = result.map
          map.sourcesContent = getSourcesContent(map.sources)
          sourceMap = new Buffer(JSON.stringify(map)).toString('base64')
          css = css.replace(/\/\*# sourceMappingURL=.*\*\//, '/*# sourceMappingURL=data:application/json;base64,' + sourceMap + '*/')

        opts.content = css
        next()
      else
        next()
