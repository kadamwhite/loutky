'use strict';

var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var browserify = require('browserify-middleware');

var app = express();


// Middleware setup
app.use( favicon( __dirname + '/public/images/favicon.png' ) );

// Serve static assets
app.use( express.static( path.join( __dirname, 'public' ) ) );

// Single, catch-all router
app.use( /\/\w*/, function( req, res, next ) {
  res.sendFile( __dirname + '/public/index.html' );
});

// Initialize the server
app.set( 'port', process.env.PORT || 3000 );

var server = app.listen(app.get('port'), function() {
  console.log('Express server listening on port ' + server.address().port);
});
