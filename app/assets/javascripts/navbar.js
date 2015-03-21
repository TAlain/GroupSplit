$(document).ready(function() {
    setGroupId()

    $('a#group_id').click(function() {
        var group_id = $(this).attr('class_id');
        localStorage.setItem('group_id', group_id);
    })

});

function setGroupId() {
    var group_id = localStorage.getItem('group_id');
    $('#bill_group').attr('value', group_id);
}