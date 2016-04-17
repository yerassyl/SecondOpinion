//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready page:load', function(){

    var updateResumeBtn = $('#update_resume_btn');
    var updateResumeForm = $('#update_resume_form');
    updateResumeBtn.on('click', function(){
        updateResumeForm.css({display: 'block'});
    });

	// When the user clicks anywhere outside of the updateResumeForm, close it
	window.onclick = function(event) {
	    if (event.target == updateResumeForm) {
	        updateResumeForm.style.display = "none";
	    }
	}

});