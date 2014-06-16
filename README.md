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
npm install --save docpad-plugin-nodesass
```


### Output Style
```coffeescript
outputStyle: 'nested'|'compressed'
```

`outputStyle` is a `String` to determine how the final CSS should be rendered. Its value should be one of `'nested'` or `'compressed'`. `'expanded'` and `'compact'` are not currently supported by [libsass](https://github.com/hcatlin/libsass).


### Image Path
```coffeescript
imagePath: '/path/to/images'
```

`imagePath` is a `String` that represents the public image path. When using the `image-url()` function in a stylesheet, this path will be prepended to the path you supply. eg. Given an `imagePath` of `/path/to/images`, `background-image: image-url('image.png')` will compile to `background-image: url("/path/to/images/image.png")`

### Precision
```coffeescript
precision: 5
```

`precision` is a `Number` that will be used to determine how many digits after the decimal will be allowed. For instance, if you had a decimal number of `1.23456789` and a precision of `5`, the result will be `1.23457` in the final CSS.

### Bourbon

```coffeescript
bourbon: false|true
```

If set to `true`, the [Bourbon](http://bourbon.io/) mixin library will be available for use. (Using the [node port](https://github.com/lacroixdesign/node-bourbon))

### Debug Info

```coffeescript
debugInfo: false|'normal'|'map'
```

`normal` will print comments in the output css that indicates the source file name and line number. `map` will produce a sourcemap. Using either of these options instead of `none` will prevent you from being able to run any other process on the file (e.g. `FILE.css.scss.eco`), because `debugInfo` requires passing an actual file instead of `stdin`.

### Neat

```coffeescript
neat: false|true
```

If set to `true`, the [Neat](http://neat.bourbon.io/) semantic grid framework will be available for use. (Using the [node port](https://github.com/lacroixdesign/node-neat).) Setting this to `true` will also set `bourbon` to `true`.

### Render Underscore Stylesheets

```coffeescript
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
