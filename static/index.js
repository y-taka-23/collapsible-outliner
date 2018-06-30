'use strict';

require('./index.html');
require('./style.scss');

var Elm = require('../src/Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);
