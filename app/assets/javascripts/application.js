// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require foundation
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require cocoon
//= require select2
//= require filterrific/filterrific-jquery
//= require_tree .

//$(function(){
//    $(document).foundation();
//});
$(document).on('ready page:load', function () {
    $(function(){ $(document).foundation(); });
    $('.assign-doctor').select2();
    $('#medical_service_specialization_id').select2();
});

//
//$(document).on('ready page:load',function(){
//
//});

$(document).on('page:load', function(){

});
