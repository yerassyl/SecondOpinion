//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('ready page:load',function(){

    var newMedSituationBtn = $('#new_med_situation_btn');
    var medSituationForm = $('#new_medical_situation');
    var submitMedicalSituation = $('#submit_medical_situation');

    var loadMoreMedSituationsBtn = $('#load_more_med_situations');

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

    loadMoreMedSituationsBtn.on('click', function(event){
        event.preventDefault();
        var loading_spinner = $('.loading-gif');
        loadMoreMedSituationsBtn.hide();
        loading_spinner.show();

        // get the last id and save it in a variable 'last-id'
        var last_id = $('.record').last().attr('data-id');

        $.ajax({
            url: $(this).attr('href'),
            dataType: 'script',
            method: 'GET',
            data: {
                id: last_id
            },
            success: function () {
                // hide the loading gif
                loading_spinner.hide();
                // show our load more link
                loadMoreMedSituationsBtn.show();
            },
            error: function(){
                loading_spinner.hide();
                loadMoreMedSituationsBtn.show();
            }
        });

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
