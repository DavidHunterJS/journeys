$(document).ready(function() {
    // affix the navbar after scroll below header
    $('#nav').affix({
        offset: {
            top: $('header').height() - $('#nav').height()
        }
    });
    
    // BACKGROUND SLIDESHOW using Backstretch
    $("#section0").backstretch([
        "./img/012.jpg",
        "./img/005.jpg",
        "./img/009.jpg"
    ], {
        duration: 3000,
        fade: 750
    });


    // Masonry plugin fixes vertical space issue with client tiles
    $(window).load(function(){
        $('.grid').masonry({
            itemSelector: '.grid-item'
        });
    });

    // highlight the top nav as scrolling occurs
    $('body').scrollspy({
        target: '#nav'
    });

    // smooth scrolling for scroll to top
    $('.scroll-top').click(function() {
        $('body,html').animate({
            scrollTop: 0
        }, 1000);
    });

    // smooth scrolling for nav sections
    $('#nav .navbar-nav li>a').click(function() {
        
        // fixes mobile nav landing spots
        var navHeight = $('#nav').height();
        var altHeight = 0;
        // mobile fix that uses the presence of 
        // the affix class as a conditional to 
        // set the height of the scrollTop position
        $("#nav").hasClass("affix") ? altHeight = 0 : altHeight = navHeight;
        
        // smooth scrolling
        var link = $(this).attr('href');
        var posi = $(link).offset().top + 10 - altHeight;
        $('body,html').animate({
            scrollTop: posi
        }, 700);

        // this sets the active li in nav
        // by Removing the active class from the clicked el
        $(this).parent().removeClass('active');
    });

    // this will auto collapse the nav menu on mobile
    $(document).on('click','.navbar-collapse.in',function(e) {
        if( $(e.target).is('a') && $(e.target).attr('class') != 'dropdown-toggle' ) {
          $(this).collapse('hide');
        }
    });

    // adds current year automatically to footer
    $(".year").html(new Date().getFullYear());

    // GOOGLE MAPS

    //enable the visual refresh
    google.maps.visualRefresh = true;

    var map;

    function initialize() {
        var mapCanvas = document.getElementById('map-canvas');
        var mapOptions = {
            center: new google.maps.LatLng(38.107, -122.569),
            zoom: 14,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            scrollwheel: false
        };
        map = new google.maps.Map(mapCanvas,mapOptions);
    }

    google.maps.event.addDomListener(window, 'load', initialize);
});