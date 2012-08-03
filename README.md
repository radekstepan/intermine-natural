# InterMine Natural

Natural Language User Interface for InterMine models.

## Dependencies:

First, SWI Prolog needs to be installed:

```bash
$ sudo apt-get install swi-prolog
```

Then, the node.js dependencies. Make sure to have [Node.js](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager) installed, then get the package dependencies:

```bash
$ npm install -d
```

## Test:

[Mocha](http://visionmedia.github.com/mocha/) is used as a test runner and is configured through npm:

```bash
$ npm test
```