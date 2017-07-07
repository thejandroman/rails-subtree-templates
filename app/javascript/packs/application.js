/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker');

// from https://stackoverflow.com/questions/29421409/how-to-load-all-files-in-a-subdirectories-using-webpack-without-require-statemen
function requireAll(r) { r.keys().forEach(r); }
requireAll(require.context('./images/', true, /\.png$/));
