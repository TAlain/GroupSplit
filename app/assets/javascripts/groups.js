$(document).ready(function() {
    var selected_Members;

    $('.select_members','#members-container').click(function() {
        selected_Members='';
        $(this).toggleClass('selected');
        $('.selected','#members-container').each (function( index, element ){
            selected_Members = selected_Members +( $( element).attr('id')+ ',');
        });
        $('#members_ids').attr('value', selected_Members);
    });

    $('.group-delete').click(function(e) {
        e.preventDefault();
        bootbox.confirm("Are you sure you want to delete this group? It will also delete all related Bills", function(result) {
            if(result) {
                $(".edit_group", ".delete").submit();
            }
        });
    });
});
