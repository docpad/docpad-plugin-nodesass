'use strict'

const fs = require('fs')
const path = require('path')
const sass = require('node-sass')
const bourbon = require('node-bourbon').includePaths
const neat = require('node-neat').includePaths
let {map} = require('async')
const BasePlugin = require('docpad-baseplugin')

// Export Plugin
module.exports = class NodesassPlugin extends BasePlugin {
	get name () {
		return 'nodesass'
	}

	get initialConfig () {
		return {
			bourbon: false,
			debugInfo: false,
			neat: false,
			renderUnderscoreStylesheets: false,
			sourceMap: false
		}
	}

	// Warn about use of deprecated options
	docpadReady () {
		const {
			config
		} = this
		if (config.bourbon || config.neat) {
			return console.warn('nodesass: ' + 'The Bourbon and Neat options are deprecated and will be removed in the next major version. Please use includePaths instead (example in README.md)'.red)
		}
	}

	// Prevent underscore
	extendCollections () {
		// Prevent underscore files from being written if desired
		if (this.config.renderUnderscoreStylesheets === false) {
			this.underscoreStylesheets = this.docpad.getDatabase().findAllLive({filename: /^_(.*?)\.(?:scss|sass)/})
			return this.underscoreStylesheets.on('add', (model) => model.set({
				render: false,
				write: false
			}))
		}
	}

	// Render some content
	render (opts, next) {
		// Prepare
		const {
			config
		} = this
		const paths = []

		const {inExtension, outExtension, file} = opts

		// If SASS/SCSS then render
		if (['sass', 'scss'].includes(inExtension) && ['css', null].includes(outExtension)) {
			// Fetch useful paths
			const fullDirPath = file.get('fullDirPath')

			// Read sources & return content
			const getSourceContent = (source, next) => fs.readFile(path.join(fullDirPath, source), {encoding: 'utf8'}, next)
			const getSourcesContent = (sources, done) => map(sources, getSourceContent, done)

			// Prepare the command and options
			const cmdOpts = {...config.options}

			if (fullDirPath) {
				let path_
				paths.push(fullDirPath)

				if (config.bourbon) {
					for (path_ of Array.from(bourbon)) {
						paths.push(path_)
					}
				}
				if (config.neat) {
					for (path_ of Array.from(neat)) {
						paths.push(path_)
					}
				}
			}

			cmdOpts.includePaths = cmdOpts.includePaths ? cmdOpts.includePaths.concat(paths) : paths

			if (config.debugInfo && (config.debugInfo !== 'none')) {
				cmdOpts.sourceComments = config.debugInfo
				cmdOpts.file = file.attributes.fullPath
			}
			else {
				cmdOpts.data = opts.content
			}

			// Spawn the appropriate process to render the content
			return sass.render(cmdOpts, function (err, result) {
				if (err) {
					return next(err)
				}

				let css = result.css.toString() // sass.render gives a Buffer object, but sourcemaps and other docpad plugins (partials) require strings

				if (result.map && result.map.sources) {
					({
						map
					} = result)
					return getSourcesContent(map.sources, function (err, sourcesContent) {
						if (err) {
							return next(err)
						}

						map.sourcesContent = sourcesContent
						const sourceMap = new Buffer(JSON.stringify(map)).toString('base64')
						css = css.replace(/\/\*# sourceMappingURL=.*\*\//, '/*# sourceMappingURL=data:application/json;base64,' + sourceMap + '*/')

						opts.content = css
						return next()
					})
				}
				else {
					opts.content = css
					return next()
				}
			})
		}
		else {
			return next()
		}
	}
}
