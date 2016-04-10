//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready page:load', function(){

	var updateResumeBtn = document.getElementById('update_resume_btn');
	var updateResumeForm = document.getElementById('update_resume_form');

	updateResumeBtn.onclick = function() {
	    updateResumeForm.style.display = "block";
	}

	// When the user clicks anywhere outside of the updateResumeForm, close it
	window.onclick = function(event) {
	    if (event.target == updateResumeForm) {
	        updateResumeForm.style.display = "none";
	    }
	}

});