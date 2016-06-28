$(document).ready ->

  initialize = ->
    mapCanvas = document.getElementById('map-canvas')
    mapOptions = 
      center: new (google.maps.LatLng)(38.107, -122.569)
      zoom: 14
      mapTypeId: google.maps.MapTypeId.ROADMAP
      scrollwheel: false
    map = new (google.maps.Map)(mapCanvas, mapOptions)
    return

  # affix the navbar after scroll below header
  $('#nav').affix offset: top: $('header').height() - $('#nav').height()
  
  # BACKGROUND SLIDESHOW using Backstretch
  $('#section0').backstretch [
    './img/012.jpg'
    './img/005.jpg'
    './img/009.jpg'
  ],
    duration: 3000
    fade: 750
  
  # Masonry plugin 
  # on window load fixes issue with overlapping masonry items
  $(window).load ->
    $('.grid').masonry itemSelector: '.grid-item'
    return
  
  # highlight the top nav as scrolling occurs
  $('body').scrollspy target: '#nav'
  
  # smooth scrolling for scroll to top
  $('.scroll-top').click ->
    $('body,html').animate { scrollTop: 0 }, 1000
    return
  
  # smooth scrolling for nav sections
  $('#nav .navbar-nav li>a').click ->
    # fixes mobile nav landing spots
    navHeight = $('#nav').height()
    altHeight = 0
    # mobile fix that uses the presence of 
    # the affix class as a conditional to 
    # set the height of the scrollTop position
    if $('#nav').hasClass('affix') then (altHeight = 0) else (altHeight = navHeight)
    # smooth scrolling
    link = $(this).attr('href')
    posi = $(link).offset().top + 10 - altHeight
    $('body,html').animate { scrollTop: posi }, 700
    # this sets the active li in nav
    # by Removing the active class from the clicked el
    $(this).parent().removeClass 'active'
    return
  
  # this will auto collapse the nav menu on mobile
  $(document).on 'click', '.navbar-collapse.in', (e) ->
    if $(e.target).is('a') and $(e.target).attr('class') != 'dropdown-toggle'
      $(this).collapse 'hide'
    return
  
  # adds current year automatically to footer
  $('.year').html (new Date).getFullYear()
  
  # GOOGLE MAPS
  #enable the visual refresh
  google.maps.visualRefresh = true
  map = undefined
  google.maps.event.addDomListener window, 'load', initialize
  return
