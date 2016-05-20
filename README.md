# [SCSS](http://sass-lang.com/) Plugin for [DocPad](https://docpad.org) using [node-sass](https://github.com/andrew/node-sass)

[![NPM version](https://badge.fury.io/js/docpad-plugin-nodesass.png)](https://npmjs.org/package/docpad-plugin-nodesass "View this project on NPM")
[![Dependency Status](https://gemnasium.com/jking90/docpad-plugin-nodesass.png)](https://gemnasium.com/jking90/docpad-plugin-nodesass)
[![Build Status](https://travis-ci.org/jking90/docpad-plugin-nodesass.png?branch=master)](https://travis-ci.org/jking90/docpad-plugin-nodesass)
[![Gittip donate button](http://img.shields.io/gittip/jking90.png)](https://www.gittip.com/jking90/ "Donate weekly to this project using Gittip")

> Adds support for the [SCSS](http://sass-lang.com/) CSS pre-processor to [DocPad](https://docpad.org).

The indented `.sass` syntax is not supported by [node-sass](https://github.com/andrew/node-sass), so it is not supported by this plugin.

Convention:  `.css.scss`


## Install

```bash
docpad install nodesass
```


### Output Style
```coffeescript
outputStyle: 'nested'|'compressed'
```

`outputStyle` is a `String` to determine how the final CSS should be rendered. Its value should be one of `'nested'` or `'compressed'`. `'expanded'` and `'compact'` are not currently supported by [libsass](https://github.com/hcatlin/libsass).

### Options
An object that you can use to [pass options to node-sass](https://github.com/sass/node-sass#options)

### Debug Info

```coffeescript
debugInfo: false|'normal'|'map'
```

`normal` will print comments in the output css that indicates the source file name and line number. `map` will produce a sourcemap. Using either of these options instead of `none` will prevent you from being able to run any other process on the file (e.g. `FILE.css.scss.eco`), because `debugInfo` requires passing an actual file instead of `stdin`.

### Render Underscore Stylesheets

```coffeescript
renderUnderscoreStylesheets: false|true
```

By default we prevent any SCSS stylesheets that filename starts with underscore character from being rendered and written to the output directory. This is to follow SCSS convention that such files are just intended to be included inside our stylesheets, and that they are not meant to be rendered by themselves. If you really want to, you can render the underscore stylesheets by setting the `renderUnderscoreStylesheets` option to `true` in your plugin's configuration.

### import-once example

The [node-sass-import-once](https://www.npmjs.com/package/node-sass-import-once) module speeds up rendering by only importing files once. It also adds a few additional features including automatically importing from `bower_components/`.

Install it with

```bash
npm install --save node-sass-import-once
```

And then configure it by setting the `nodesass.options.importer` to the import-once module:

```coffee
    plugins:
        nodesass:
            options:
                importer: require('node-sass-import-once')
                importOnce:
                    index: true # @import 'foo'; will load foo/_index.scss if foo is a folder
                    css: true # @import 'bar'; will import bar.css
                    bower: true # automatically search bower_components directory for imports
```

### Bourbon example

The [node-bourbon](https://github.com/lacroixdesign/node-bourbon) module includes a simple and lightweight mixin library.

Install it with

```bash
npm install --save node-bourbon
```

And then configure it by setting `nodesass.options.includePaths` to the `includePaths` provided by the module.

```coffee
    plugins:
        nodesass:
            options:
                includePaths: require('node-bourbon').includePaths
```

## History
[You can discover the history inside the `History.md` file](https://github.com/jking90/docpad-plugin-nodesass/blob/master/History.md)


## Contributing
[You can discover the contributing instructions inside the `Contributing.md` file](https://github.com/jking90/docpad-plugin-nodesass/blob/master/Contributing.md)


## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2012+ [Bevry Pty Ltd](http://bevry.me) <us@bevry.me>
<br/>Copyright &copy; 2013+ [Jimmy King](http://jimmyking.me) <hello@jimmyking.me>
