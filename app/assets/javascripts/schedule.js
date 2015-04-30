    //change time interval
    jQuery(document).on('change','#timeslot_interval',function() {
        var interval = jQuery(this).val();
        location.href = '/schedule?interval=' + interval;
    });