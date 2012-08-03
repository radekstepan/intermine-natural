# InterMine Natural

Natural Language User Interface for InterMine models.

![image](https://github.com/radekstepan/intermine-natural/raw/master/misc/test.png)

## Dependencies:

First, SWI Prolog needs to be installed:

```bash
$ sudo apt-get install swi-prolog
```

Then, the node.js dependencies. Make sure to have [Node.js](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager) installed, then get the package dependencies:

```bash
$ npm install -d
```

## Run server:

The [flatiron](http://flatironjs.org/) server is started on port `1115` as follows:

```bash
$ ./node_modules/.bin/coffee server.coffee
```

## Test:

[Mocha](http://visionmedia.github.com/mocha/) is used as a test runner and is configured through npm:

```bash
$ npm test
```

## Architecture

![image](https://github.com/radekstepan/intermine-natural/raw/master/misc/architecture.jpg)