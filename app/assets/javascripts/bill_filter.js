$(document).ready(function() {
    var group_id = $('.group_select').val();

    $(".group_select").change(function() {
        var group_id = $('.group_select').val();

        if (group_id != "all") {
            window.location.replace('/bills/?group_id=' + group_id);
        } else {
            window.location.replace('/bills');
        }

    });
});