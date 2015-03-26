$(document).ready(function() {
    var group_id = $('.group_select').val();
    var user_id  = $('.user_select').val();

    $(".group_select").change(function() {
        var group_id = $('.group_select').val();

        if (group_id != "all") {
            window.location.replace('/bills/?group_id=' + group_id);
        } else {
            window.location.replace('/bills');
        }

    });

    $(".user_select").change(function() {
        var user_id = $('.user_select').val();

        if (user_id != "all") {
            window.location.replace('/bills/?group_id=' + group_id+'&user_id=' + user_id);
        } else {
            window.location.replace('/bills/?group_id=' + group_id);
        }

    });
});