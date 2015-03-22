$(document).ready(function() {
    setGroupId()

    $('a#group_id').click(function() {
        var group_id = $(this).attr('class_id');
        localStorage.setItem('group_id', group_id);
        localStorage.setItem('group_name',$(this).text());
    });
});

function setGroupId() {
    var group_id = localStorage.getItem('group_id')
    var group_name = localStorage.getItem('group_name');
    $('#bill_group').attr('value', group_id);
    $('.bill_title').text('New bill for '+ group_name);

    $.get('/bills/new.json?group_id=' + group_id, group_id);
}