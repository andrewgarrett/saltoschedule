/**
 * Created by andreikraykov on 12/4/14.
 */
jQuery(document).ready(function(){
    //check obx on and off
    jQuery('.chk_schedule').click(function(){
        var index = jQuery('.chk_schedule').index(jQuery(this));
        console.log(index);
        if(jQuery(this).is(':checked')) {
            jQuery('tr#start_row').children('td').eq(index+1).find('select').show();
            jQuery('tr#end_row').children('td').eq(index+1).find('select').show();
        }else{
            //hide two schedules
            jQuery('tr#start_row').children('td').eq(index+1).find('select').hide();
            jQuery('tr#end_row').children('td').eq(index+1).find('select').hide();
        }

    })

    //onload
    jQuery('.chk_schedule').each(function(index, element){
        if(jQuery(element).is(':checked')) {
            jQuery('tr#start_row').children('td').eq(index+1).find('select').show();
            jQuery('tr#end_row').children('td').eq(index+1).find('select').show();
        }else{
            //hide two schedules
            jQuery('tr#start_row').children('td').eq(index+1).find('select').hide();
            jQuery('tr#end_row').children('td').eq(index+1).find('select').hide();
        }

    })

    //add row
    jQuery('#add_stipulation').click(function(){
        var total_events = jQuery('#events_table tbody tr.event_row').length;
       // alert('fuck');
        jQuery('#events_table tr.event_row').eq(0).clone().insertAfter(jQuery('#events_table tbody tr.event_row').eq(total_events-1));
    })

    //delete row
    jQuery('a.remove_event').click(function(){
        var total_events = jQuery('#events_table tbody tr.event_row').length;

        if(total_events==1)
            return false;
        jQuery(this).parent().parent().remove();
        return false;
    })
    //time slot
    jQuery('#timeslot_interval_form').change(function() {
        var interval = jQuery(this).val();
        jQuery('#create_schedule').attr('href','/schedule?interval=' + interval);
        jQuery('ul.nav li:nth-child(3)').find('a').href=location.href;
    });
})

