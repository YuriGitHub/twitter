var prepare_form = null;
var edit_post = null;
var submit_form = null;
var submit_form_default_url = null;
$(document).ready(function(){
    submit_form_default_url = $('#new_post').attr('action');
    var is_submiting = false;
    submit_form = function(btn){
        if(!is_submiting){
            $('#new_post').submit();
            is_submiting = true;
            $(btn).prop('disabled',true)
        }
    }
    prepare_form = function(method){
        $('#new_post').attr('method',method)
        $('#header_field').val("")
        $('#text_field').val("")
        if(method == "post"){

            $('#submit_button').html('Create post')
            $('#form_title').html('New post')
            $('#new_post').attr('action',submit_form_default_url)
        }
        else{
            $('#submit_button').html('Update post')
            $('#form_title').html('Update post')
        }
    }

    edit_post = function(call_element){

        $('#new_post').attr('action',submit_form_default_url+"/"+$(call_element).closest('.main').attr('id'))
        prepare_form('put')
        $('#create-form').modal('toggle')
        var main = call_element.closest('.main')
        console.log(main)
        $('#header_field').val($(main).find('.post_header').html())
        $('#text_field').val($(main).find('.post_text').html())
    }

    $('#new_post').on('ajax:success',function(xhr,data,status){
        var file_form  = $('#file_upload_form')
        var res_arr = file_form.attr('action').split('0')
        res_arr[0] = res_arr[0]+data.id
        file_form.attr('action',res_arr.join(""))
        submit_all();
    })
});
//Destroy with AJAX 
$(document).on('ajax:success', '#del_ps', function() {
    $(this).closest(".main").slideUp();
}); 
