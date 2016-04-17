//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready page:load', function(){

    var updateResumeBtn = $('#update_resume_btn');
    var updateResumeForm = $('#update_resume_form');


    // When the user clicks anywhere outside of the updateResumeForm, close it
    $('#update_resume_cancel').on('click', function(event){
        console.log('upd_Cancel');
        event.preventDefault();
        updateResumeForm.css({display: 'none'});
    });

    //$('html').on('click', function(event) {
    //    if (event){
    //        updateResumeForm.css({display: 'none'});
    //    }
    //});

    updateResumeBtn.on('click', function(){
        updateResumeForm.css({display: 'block'});
    });



});