//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.


$(document).ready(function(){

    $('#new_call_back').on('ajax:success', function(e,data,status,xhr){
        console.log("success");
        // show success message to client
        // due to some problems with ajax:success detection this is done in create.js.erb


    }).on('ajax:error',function(e,data,status,xhr){
        console.log("error");
        // show error messages on input fields
        var response = JSON.parse(data.responseText);
        if (response.name!=null){
            $('#call_back_name').addClass("error-input-field").removeClass('input-field').attr('placeholder', response.name);
        }
        if (response.country!=null){
            $('#call_back_country').addClass("error-input-field").removeClass("input-field");
        }
        if (response.phone!=null){
            $('#call_back_phone').addClass("error-input-field").removeClass('input-field').attr('placeholder',response.phone);
        }
        if (response.language!=null){
            $('#call_back_language').addClass("error-input-field").removeClass("input-field");
        }
        if (response.email!=null){
            $('#call_back_email').addClass("error-input-field").removeClass('input-field').attr('placeholder',response.email);
            $('#email-message').text(response.email);
        }
        if (response.specialization!=null){
            $('#call_back_specialization').addClass("error-input-field").removeClass('input-field');
        }

        if (response.message!=null){
            $('#call_back_phone').addClass("error-input-field").removeClass('input-field').attr('placeholder',response.message);
        }
        if (response.didAgree!=null){
            var checkbox = $(".checkbox");
            checkbox.append(checkbox.has('span').length ? '' : '<span class="alert">'+response.didAgree+'</span>');

        }


    });

});
