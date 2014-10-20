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
//= require_tree .

var colorTab = function () {
  if ($('.dashboard-div').length !== 0) {
    $('.dashboard-link').css('color', '#257340');
  }
  if ($('.follow-div').length !== 0) {
    $('.follow-header-link').css('color', '#257340');
  }
  if ($('.search-display').length !== 0) {
    $('.search-link').css('color', '#257340');
  }
  if ($('.favorite-div').length != 0) {
    $('.favorite-header-link').css('color', '#257340');
  }
};

var openHeadermenu = function () {
  $('#header-menu-toggle').click(function (e) {
    e.stopPropagation();
    $('.header-menu').toggle();
  });

  $('.header-menu').click(function(e){
    e.stopPropagation();
  });

  $('body').click(function(){
    $('.header-menu').hide();
  });
};


$(document).ready(function () {
  colorTab();

  openHeadermenu();


});