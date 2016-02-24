//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){
    var newMedSituationBtn = $('#new_med_situation_btn');
    var medSituationForm = $('#new_medical_situation');
    var submitMedicalSituation = $('#submit_medical_situation');

    // medical situation form inputs
    var reason = $('#medical_situation_reason');

    medSituationForm.hide();

    newMedSituationBtn.on('click', function(event){
        event.preventDefault();
        medSituationForm.toggle();
    });

    // when medical situation form is submitted
    submitMedicalSituation.on('click', function(event){
        var reasonStr = reason.val();
        if (reasonStr==""){
            event.preventDefault();
            reason.addClass("error-input-field").removeClass("input-field").attr('placeholder','this field cant be blank');
        }

    });



    // new medical situation form
    //$('#new_medical_situation').on("ajax:success", function(e,data,status,xhr){
    //    console.log("new_medical_situation success: ")
    //}).on("ajax:error", function(e,xhr,status,error){
    //    console.log("new_medical_situation: "+error+" status: "+status+" e: "+ e+" xhr: "+xhr.reason+"");
    //    var response = JSON.parse(xhr.responseText);
    //    if (response.reason != null){
    //        $('#medical_situation_reason').addClass("error-input-field").removeClass('input-field').attr('placeholder', response.reason);
    //    }
    //
    //});

});
