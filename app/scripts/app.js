require('./album');
require('./album_collection');
require('./user_profile');
require('./practice');
require('./controllers');
require('./models');
require('./services');

// Top level application module for our website.
angular.module('BlocJams', [
  'Models',
  'Controllers',
  'Services'
]).config(function ($compileProvider) {
  // Prevent angular from marking links with a variety of protocols "unsafe"
  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|webcal|mailto|file|tel):/);
});

