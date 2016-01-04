//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
    var callback = $("#client-callback");

    $("#form-header").click(function(){
        console.log("callback click");
        if (callback.hasClass("callback-hidden")){
            callback.removeClass("callback-hidden").addClass("callback-shown");
        }else {
            callback.removeClass("callback-shown").addClass("callback-hidden");
        }
    });

});

