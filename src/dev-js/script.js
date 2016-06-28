$(document).ready(function() {
  var initialize, map;
  initialize = function() {
    var map, mapCanvas, mapOptions;
    mapCanvas = document.getElementById('map-canvas');
    mapOptions = {
      center: new google.maps.LatLng(38.107, -122.569),
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      scrollwheel: false
    };
    map = new google.maps.Map(mapCanvas, mapOptions);
  };
  $('#nav').affix({
    offset: {
      top: $('header').height() - $('#nav').height()
    }
  });
  $('#section0').backstretch(['./img/012.jpg', './img/005.jpg', './img/009.jpg'], {
    duration: 3000,
    fade: 750
  });
  $(window).load(function() {
    $('.grid').masonry({
      itemSelector: '.grid-item'
    });
  });
  $('body').scrollspy({
    target: '#nav'
  });
  $('.scroll-top').click(function() {
    $('body,html').animate({
      scrollTop: 0
    }, 1000);
  });
  $('#nav .navbar-nav li>a').click(function() {
    var altHeight, link, navHeight, posi;
    navHeight = $('#nav').height();
    altHeight = 0;
    if ($('#nav').hasClass('affix')) {
      altHeight = 0;
    } else {
      altHeight = navHeight;
    }
    link = $(this).attr('href');
    posi = $(link).offset().top + 10 - altHeight;
    $('body,html').animate({
      scrollTop: posi
    }, 700);
    $(this).parent().removeClass('active');
  });
  $(document).on('click', '.navbar-collapse.in', function(e) {
    if ($(e.target).is('a') && $(e.target).attr('class') !== 'dropdown-toggle') {
      $(this).collapse('hide');
    }
  });
  $('.year').html((new Date).getFullYear());
  google.maps.visualRefresh = true;
  map = void 0;
  google.maps.event.addDomListener(window, 'load', initialize);
});
