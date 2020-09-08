<!-- TITLE/ -->

<h1>docpad-plugin-nodesass</h1>

<!-- /TITLE -->


<!-- BADGES/ -->

<span class="badge-travisci"><a href="http://travis-ci.com/docpad/docpad-plugin-nodesass" title="Check this project's build status on TravisCI"><img src="https://img.shields.io/travis/com/docpad/docpad-plugin-nodesass/master.svg" alt="Travis CI Build Status" /></a></span>
<span class="badge-npmversion"><a href="https://npmjs.org/package/docpad-plugin-nodesass" title="View this project on NPM"><img src="https://img.shields.io/npm/v/docpad-plugin-nodesass.svg" alt="NPM version" /></a></span>
<span class="badge-npmdownloads"><a href="https://npmjs.org/package/docpad-plugin-nodesass" title="View this project on NPM"><img src="https://img.shields.io/npm/dm/docpad-plugin-nodesass.svg" alt="NPM downloads" /></a></span>
<span class="badge-daviddm"><a href="https://david-dm.org/docpad/docpad-plugin-nodesass" title="View the status of this project's dependencies on DavidDM"><img src="https://img.shields.io/david/docpad/docpad-plugin-nodesass.svg" alt="Dependency Status" /></a></span>
<span class="badge-daviddmdev"><a href="https://david-dm.org/docpad/docpad-plugin-nodesass#info=devDependencies" title="View the status of this project's development dependencies on DavidDM"><img src="https://img.shields.io/david/dev/docpad/docpad-plugin-nodesass.svg" alt="Dev Dependency Status" /></a></span>
<br class="badge-separator" />
<span class="badge-githubsponsors"><a href="https://github.com/sponsors/balupton" title="Donate to this project using GitHub Sponsors"><img src="https://img.shields.io/badge/github-donate-yellow.svg" alt="GitHub Sponsors donate button" /></a></span>
<span class="badge-patreon"><a href="https://patreon.com/bevry" title="Donate to this project using Patreon"><img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" /></a></span>
<span class="badge-flattr"><a href="https://flattr.com/profile/balupton" title="Donate to this project using Flattr"><img src="https://img.shields.io/badge/flattr-donate-yellow.svg" alt="Flattr donate button" /></a></span>
<span class="badge-liberapay"><a href="https://liberapay.com/bevry" title="Donate to this project using Liberapay"><img src="https://img.shields.io/badge/liberapay-donate-yellow.svg" alt="Liberapay donate button" /></a></span>
<span class="badge-buymeacoffee"><a href="https://buymeacoffee.com/balupton" title="Donate to this project using Buy Me A Coffee"><img src="https://img.shields.io/badge/buy%20me%20a%20coffee-donate-yellow.svg" alt="Buy Me A Coffee donate button" /></a></span>
<span class="badge-opencollective"><a href="https://opencollective.com/bevry" title="Donate to this project using Open Collective"><img src="https://img.shields.io/badge/open%20collective-donate-yellow.svg" alt="Open Collective donate button" /></a></span>
<span class="badge-crypto"><a href="https://bevry.me/crypto" title="Donate to this project using Cryptocurrency"><img src="https://img.shields.io/badge/crypto-donate-yellow.svg" alt="crypto donate button" /></a></span>
<span class="badge-paypal"><a href="https://bevry.me/paypal" title="Donate to this project using Paypal"><img src="https://img.shields.io/badge/paypal-donate-yellow.svg" alt="PayPal donate button" /></a></span>
<span class="badge-wishlist"><a href="https://bevry.me/wishlist" title="Buy an item on our wishlist for us"><img src="https://img.shields.io/badge/wishlist-donate-yellow.svg" alt="Wishlist browse button" /></a></span>

<!-- /BADGES -->


> Adds support for the [SCSS](http://sass-lang.com/) CSS pre-processor to [DocPad](https://docpad.org).

The indented `.sass` syntax is not supported by [node-sass](https://github.com/andrew/node-sass), so it is not supported by this plugin.

Convention: `.css.scss`




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








<!-- INSTALL/ -->

<h2>Install</h2>

Install this DocPad plugin by entering <code>docpad install nodesass</code> into your terminal.

<!-- /INSTALL -->


<!-- HISTORY/ -->

<h2>History</h2>

<a href="https://github.com/docpad/docpad-plugin-nodesass/blob/master/HISTORY.md#files">Discover the release history by heading on over to the <code>HISTORY.md</code> file.</a>

<!-- /HISTORY -->


<!-- CONTRIBUTE/ -->

<h2>Contribute</h2>

<a href="https://github.com/docpad/docpad-plugin-nodesass/blob/master/CONTRIBUTING.md#files">Discover how you can contribute by heading on over to the <code>CONTRIBUTING.md</code> file.</a>

<!-- /CONTRIBUTE -->


<!-- BACKERS/ -->

<h2>Backers</h2>

<h3>Maintainers</h3>

These amazing people are maintaining this project:

<ul><li><a href="10x.la/croixdrinker">Jimmy King</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=10xLaCroixDrinker" title="View the GitHub contributions of Jimmy King on repository docpad/docpad-plugin-nodesass">view contributions</a></li></ul>

<h3>Sponsors</h3>

No sponsors yet! Will you be the first?

<span class="badge-githubsponsors"><a href="https://github.com/sponsors/balupton" title="Donate to this project using GitHub Sponsors"><img src="https://img.shields.io/badge/github-donate-yellow.svg" alt="GitHub Sponsors donate button" /></a></span>
<span class="badge-patreon"><a href="https://patreon.com/bevry" title="Donate to this project using Patreon"><img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" /></a></span>
<span class="badge-flattr"><a href="https://flattr.com/profile/balupton" title="Donate to this project using Flattr"><img src="https://img.shields.io/badge/flattr-donate-yellow.svg" alt="Flattr donate button" /></a></span>
<span class="badge-liberapay"><a href="https://liberapay.com/bevry" title="Donate to this project using Liberapay"><img src="https://img.shields.io/badge/liberapay-donate-yellow.svg" alt="Liberapay donate button" /></a></span>
<span class="badge-buymeacoffee"><a href="https://buymeacoffee.com/balupton" title="Donate to this project using Buy Me A Coffee"><img src="https://img.shields.io/badge/buy%20me%20a%20coffee-donate-yellow.svg" alt="Buy Me A Coffee donate button" /></a></span>
<span class="badge-opencollective"><a href="https://opencollective.com/bevry" title="Donate to this project using Open Collective"><img src="https://img.shields.io/badge/open%20collective-donate-yellow.svg" alt="Open Collective donate button" /></a></span>
<span class="badge-crypto"><a href="https://bevry.me/crypto" title="Donate to this project using Cryptocurrency"><img src="https://img.shields.io/badge/crypto-donate-yellow.svg" alt="crypto donate button" /></a></span>
<span class="badge-paypal"><a href="https://bevry.me/paypal" title="Donate to this project using Paypal"><img src="https://img.shields.io/badge/paypal-donate-yellow.svg" alt="PayPal donate button" /></a></span>
<span class="badge-wishlist"><a href="https://bevry.me/wishlist" title="Buy an item on our wishlist for us"><img src="https://img.shields.io/badge/wishlist-donate-yellow.svg" alt="Wishlist browse button" /></a></span>

<h3>Contributors</h3>

These amazing people have contributed code to this project:

<ul><li><a href="https://github.com/balupton">Benjamin Lupton</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=balupton" title="View the GitHub contributions of Benjamin Lupton on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="https://github.com/chrishale">Chris Hale</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=chrishale" title="View the GitHub contributions of Chris Hale on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="https://github.com/greenkeeperio-bot">Greenkeeper</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=greenkeeperio-bot" title="View the GitHub contributions of Greenkeeper on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="https://github.com/jankolkmeier">Jan Kolkmeier</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=jankolkmeier" title="View the GitHub contributions of Jan Kolkmeier on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="10x.la/croixdrinker">Jimmy King</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=10xLaCroixDrinker" title="View the GitHub contributions of Jimmy King on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="https://github.com/johannestroeger">Johannes Troeger</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=johannestroeger" title="View the GitHub contributions of Johannes Troeger on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="https://github.com/iammerrick">Merrick Christensen</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=iammerrick" title="View the GitHub contributions of Merrick Christensen on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="https://github.com/barlock">Michael Barlock</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=barlock" title="View the GitHub contributions of Michael Barlock on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="https://github.com/mikeumus">Michael Duane Mooring</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=mikeumus" title="View the GitHub contributions of Michael Duane Mooring on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="https://github.com/nfriedly">Nathan Friedly</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=nfriedly" title="View the GitHub contributions of Nathan Friedly on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="https://github.com/thuongdinh">Thuong Dinh</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=thuongdinh" title="View the GitHub contributions of Thuong Dinh on repository docpad/docpad-plugin-nodesass">view contributions</a></li>
<li><a href="https://github.com/0x6a68">x6a68</a> — <a href="https://github.com/docpad/docpad-plugin-nodesass/commits?author=0x6a68" title="View the GitHub contributions of x6a68 on repository docpad/docpad-plugin-nodesass">view contributions</a></li></ul>

<a href="https://github.com/docpad/docpad-plugin-nodesass/blob/master/CONTRIBUTING.md#files">Discover how you can contribute by heading on over to the <code>CONTRIBUTING.md</code> file.</a>

<!-- /BACKERS -->


<!-- LICENSE/ -->

<h2>License</h2>

Unless stated otherwise all works are:

<ul><li>Copyright &copy; <a href="10x.la/croixdrinker">Jimmy King</a></li></ul>

and licensed under:

<ul><li><a href="http://spdx.org/licenses/MIT.html">MIT License</a></li></ul>

<!-- /LICENSE -->
