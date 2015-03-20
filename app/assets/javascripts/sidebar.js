$(document).ready(function() {

    $('#left-menu').click(function() {
        transitionSidebar()
    })

    $('.nav-stacked').click(function() {
        transitionSidebar()
    })


});

function transitionSidebar() {
    $('.transition-zone').toggleClass('right');
    $('.mainContent').toggleClass('right');
    $('.navbar-custom').toggleClass('open');
}
