# InterMine Natural

Natural Language User Interface for InterMine models.

![image](https://github.com/radekstepan/intermine-natural/raw/master/misc/test.png)

## Dependencies:

First, SWI Prolog needs to be installed:

```bash
$ sudo apt-get install swi-prolog
```

Make sure to have [Node.js](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager) installed, then get the package dependencies:

```bash
$ npm install -d
```

## Run server:

The [flatiron](http://flatironjs.org/) server is started on port `1115` as follows:

```bash
$ ./node_modules/.bin/coffee server.coffee
```

Port number can be changed in `config.json`.

## Test:

[Mocha](http://visionmedia.github.com/mocha/) is used as a test runner and is configured through npm:

```bash
$ npm test
```

Alternatively, one can play around with the Prolog interpreter directly:

```bash
$ prolog -f ./prolog/resolve.pro -g "show_path([attr,of,company], []),halt"
```

The model consulted is present in `./prolog/model.pro` and is being overwriten every time the service is started with rules being taken from the `config.json` file `model` directive.

## Architecture

![image](https://github.com/radekstepan/intermine-natural/raw/master/misc/architecture.jpg)

## Natural Language User Interface (LUI) [Billings 97]

### Problems

1. anaphora resolution - "it", "he" in a self-referential query; not a problem
2. modifier attachment - "genes for proteins with length x"
3. conjunction, disjunction - "employees of company ACME & Initech"
4. ellipsis - information missing from a statement; best guess to replace vars with variables if there is no direct match
5. nominal compound problem - "gene protein"; model resolves relations

### Two types

1. a pattern-matching system (regex)
2. syntax-based system (this)

### Approach

* offers multiple possbible matches/answers for ambiguous queries
* by default only requires the model XML/JSON definition
* utilizes DCG and the backtracking power of Prolog (quick to test out)
* can be extended at runtime
* tailored and applied to a focused domain