# [SASS/SCSS](http://sass-lang.com/) Plugin for [DocPad](https://docpad.org) using [node-sass](https://github.com/andrew/node-sass)

[![NPM version](https://badge.fury.io/js/docpad-plugin-sass.png)](https://npmjs.org/package/docpad-plugin-sass "View this project on NPM")

Adds support for the [SASS and SCSS](http://sass-lang.com/) CSS pre-processors to [DocPad](https://docpad.org).

Convention:  `.css.sass|scss`


## Install


```
npm install --save docpad-plugin-nodesass
```


## Configure
For information on customizing your plugin configuration you can refer to the [DocPad FAQ](https://github.com/bevry/docpad/wiki/FAQ)


### Render Underscore Stylesheets
By default we prevent any SASS/SCSS stylesheets that filename starts with underscore character from being rendered and written to the output directory. This is to follow SASS/SCSS convention that such files are just intended to be included inside out stylesheets, and that they are not meant to be rendered by themselves. If you really want to, you can render the underscore stylesheets by setting the `renderUnderscoreStylesheets` option to `true` in your plugin's configuration.


## History
[You can discover the history inside the `History.md` file](https://github.com/jking90/docpad-plugin-nodesass/blob/master/History.md)


## Contributing
[You can discover the contributing instructions inside the `Contributing.md` file](https://github.com/jking90/docpad-plugin-nodesass/blob/master/Contributing.md)


## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2012+ [Bevry Pty Ltd](http://bevry.me) <us@bevry.me>
<br/>Copyright &copy; 2013+ [Jimmy King](http://jimmyking.me) <hello@jimmyking.me>
