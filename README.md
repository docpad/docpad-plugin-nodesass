# [SCSS](http://sass-lang.com/) Plugin for [DocPad](https://docpad.org) using [node-sass](https://github.com/andrew/node-sass)

[![NPM version](https://badge.fury.io/js/docpad-plugin-nodesass.png)](https://npmjs.org/package/docpad-plugin-nodesass "View this project on NPM")
[![Dependency Status](https://gemnasium.com/jking90/docpad-plugin-nodesass.png)](https://gemnasium.com/jking90/docpad-plugin-nodesass)


Adds support for the [SCSS](http://sass-lang.com/) CSS pre-processor to [DocPad](https://docpad.org).

The indented `.sass` syntax is not supported by [node-sass](https://github.com/andrew/node-sass), so it is not supported by this plugin.

Convention:  `.css.scss`


## Install
```
npm install --save docpad-plugin-nodesass
```


## Configure
For information on customizing your plugin configuration you can refer to the [DocPad FAQ](https://github.com/bevry/docpad/wiki/FAQ)

### Output Style
This option is not supported by [`libsass`](https://github.com/hcatlin/libsass) (and neither are sourcemaps).

### Debug Info
```
debugInfo: false|'normal'|'map'
```
`normal` will print comments in the output css that indicates the source file name and line number. `map` will produce a file the same way `--debug-info` will in the Sass CLI. Using either of these options instead of `none` will prevent you from being able to run any other process on the file (e.g. `FILE.css.scss.eco`), because `debugInfo` requires passing an actual file instead of `stdin`.

### Render Underscore Stylesheets
```
renderUnderscoreStylesheets: false|true
```
By default we prevent any SCSS stylesheets that filename starts with underscore character from being rendered and written to the output directory. This is to follow SCSS convention that such files are just intended to be included inside out stylesheets, and that they are not meant to be rendered by themselves. If you really want to, you can render the underscore stylesheets by setting the `renderUnderscoreStylesheets` option to `true` in your plugin's configuration.


## History
[You can discover the history inside the `History.md` file](https://github.com/jking90/docpad-plugin-nodesass/blob/master/History.md)


## Contributing
[You can discover the contributing instructions inside the `Contributing.md` file](https://github.com/jking90/docpad-plugin-nodesass/blob/master/Contributing.md)


## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2012+ [Bevry Pty Ltd](http://bevry.me) <us@bevry.me>
<br/>Copyright &copy; 2013+ [Jimmy King](http://jimmyking.me) <hello@jimmyking.me>
