/**
 * Created by andreikraykov on 12/4/14.
 */
$(document).ready(function(){
    //check obx on and off
    $('.chk_schedule').click(function(){
        var index = $('.chk_schedule').index($(this));
        console.log(index);
        if($(this).is(':checked')) {
            $('tr#start_row').children('td').eq(index+1).find('select').show();
            $('tr#end_row').children('td').eq(index+1).find('select').show();
        }else{
            //hide two schedules
            $('tr#start_row').children('td').eq(index+1).find('select').hide();
            $('tr#end_row').children('td').eq(index+1).find('select').hide();
        }

    })

    //onload
    $('.chk_schedule').each(function(index, element){
        if($(element).is(':checked')) {
            $('tr#start_row').children('td').eq(index+1).find('select').show();
            $('tr#end_row').children('td').eq(index+1).find('select').show();
        }else{
            //hide two schedules
            $('tr#start_row').children('td').eq(index+1).find('select').hide();
            $('tr#end_row').children('td').eq(index+1).find('select').hide();
        }

    })

    //add row
    $('#add_stipulation').click(function(){

        var total_events = $('#events_table tbody tr.event_row').length;
        console.log(total_events);
        $('#events_table tr.event_row').eq(0).clone(true).insertAfter($('#events_table tbody tr.event_row').eq(total_events-1));
    })

    //delete row
    $('a.remove_event').click(function(){
        var total_events = $('#events_table tbody tr.event_row').length;

        if(total_events==1)
            return false;
        $(this).parent().parent().remove();
        return false;
    })

})


