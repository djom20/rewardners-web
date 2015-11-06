//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-select.min
//= require bootstrap-datepicker
//= require wysihtml5-0.3.0
//= require bootstrap-wysihtml5
//= require jquery-gmaps-latlon-picker
//= require imagesloaded.pkgd.min
//= require imagesloaded
//= require waypoints.min
//= require jquery-dataTables.min
//= require jquery.appear
//= require select2
//= require select2_locale_es
//= require select2_locale_eu
//= require intlTelInput.min
//= require social-share-button
//= require shared/helpers
//= require shared/dataTable

$(document).ready(function(){
  /**** Mobile Side Menu ****/
   if ($.fn.waypoint){
  	var $head = $('#ha-header');
  	$( '.ha-waypoint' ).each( function(i) {
  		var $el = $( this ),
  			animClassDown = $el.data( 'animateDown' ),
  			animClassUp = $el.data( 'animateUp' );

  		$el.waypoint( function( direction ) {
  			if( direction === 'down' && animClassDown ) {
  				$head.attr('class', 'ha-header ' + animClassDown);
  			}
  			else if( direction === 'up' && animClassUp ){
  				$head.attr('class', 'ha-header ' + animClassUp);
  			}
  		}, { offset: '500px' } );
  	});
  }
  $('#my-task-list').popover({
      html: true,
      content: function () {
        return $('#notification-list').html();
      }
  });
  $('.js-popover').popover();


  $('#user-options').click(function () {
      $('#my-task-list').popover('hide');
  });
  setTimeout(function(){
    $('#flash_messages').remove();
  }, 5000);

  $('#tab-01 a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  });
  // $('.wysihtml5').each(function(i, elem) {
  //   $(elem).wysihtml5();
  // });
  // Content Animation Effects using Wow.js Plugin
  var wow = new WOW( {
      boxClass:     'wow',      // animated element css class (default is wow)
      animateClass: 'animated', // animation css class (default is animated)
      offset:       0,          // distance to the element when triggering the animation (default is 0)
      mobile:       true,       // trigger animations on mobile devices (default is true)
      live:         true        // act on asynchronously loaded content (default is true)
      });
  wow.init();

  // Load latest notifications messages
  $.ajax({
    url: $(".js-notifications-show").data("url"),
    dataType: "script"
  });

  $(".js-notifications-show").on('click', function(){
    $.ajax({
      url: $(this).data("url"),
      dataType: "script"
    });
  });

});

