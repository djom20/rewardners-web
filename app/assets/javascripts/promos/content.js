$(function() {
  $('#promos_container').on('click', '.pagination a', function(){
    $.getScript(this.href);
    return false;
  });

  $('#search_promo_form').submit(function(){
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });
});

$(document).ready(function(){
  var handleSidenarAndContentHeight = function () {
     var content = $('.page-content');
     var sidebar = $('.page-sidebar');

     if (!content.attr("data-height")) {
         content.attr("data-height", content.height());
     }

     if (sidebar.height() > content.height()) {
         content.css("min-height", sidebar.height() + 120);
     } else {
         content.css("min-height", content.attr("data-height"));
     }
  };

  $('.page-sidebar li > a').on('click', function (e) {
      if ($(this).next().hasClass('sub-menu') === false) {
          return;
      }
      var parent = $(this).parent().parent();


      parent.children('li.open').children('a').children('.arrow').removeClass('open');
      parent.children('li.open').children('a').children('.arrow').removeClass('active');
      parent.children('li.open').children('.sub-menu').slideUp(200);
      parent.children('li').removeClass('open');
      //  parent.children('li').removeClass('active');

      var sub = $(this).next();
      if (sub.is(":visible")) {
          $('.arrow', $(this)).removeClass("open");
          $(this).parent().removeClass("active");
          sub.slideUp(200, function () {
              handleSidenarAndContentHeight();
          });
      } else {
          $('.arrow', $(this)).addClass("open");
          $(this).parent().addClass("open");
          sub.slideDown(200, function () {
              handleSidenarAndContentHeight();
          });
      }

      e.preventDefault();
  });

  $(".js-option-category").on('click', function(e){
    $('.js-option-category').removeClass('active');
    $(this).each(function(index, el) {
      $(el).addClass('active');
    });
    e.preventDefault();
  });
  //Auto close open menus in Condensed menu
  if ($('.page-sidebar').hasClass('mini')) {
      var elem = $('.page-sidebar ul');
      elem.children('li.open').children('a').children('.arrow').removeClass('open');
      elem.children('li.open').children('a').children('.arrow').removeClass('active');
      elem.children('li.open').children('.sub-menu').slideUp(200);
      elem.children('li').removeClass('open');
  }
});
