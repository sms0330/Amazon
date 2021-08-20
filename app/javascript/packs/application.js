// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

require('bootstrap')
require('underscore')
require('./gmaps_google')
require('./selectize')
require('../stylesheets/application.scss')

// import Rails from "@rails/ujs"
// import * as ActiveStorage from "@rails/activestorage"
// import "channels"
// Rails.start()
// ActiveStorage.start()
// import "bootstrap";
// import "underscore";
// import Gmaps from "./gmaps_google";
// import '../stylesheets/application'
// import './selectize';
window.jQuery = $;
window.$ = $;
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)