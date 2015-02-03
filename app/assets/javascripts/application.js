// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require masonry.pkgd
//= require imagesloaded
//= require_tree .
  
$(function(){

  var $container = $('#container');
  $container.imagesLoaded( function() {
      $container.masonry();
  });
    
}); 

$(function(){ 

  $('.alert-success').delay(1500).fadeOut('slow');
  $('.alert-danger').delay(1500).fadeOut('slow');

});

$(document).ready(function() {
  if(document.getElementById('index-page')){
    // display popover on initial page load:
    $('body').addClass('greyscreen-open');
  
    $('.alert-popover').click(function() {
      $('body').removeClass('greyscreen-open');
    });
  }
});