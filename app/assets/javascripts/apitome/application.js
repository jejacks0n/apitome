//= require apitome/jquery-2.0.3.min
//= require apitome/bootstrap.min
//= require apitome/highlight.min

hljs.initHighlightingOnLoad();

jQuery(function(){
  $(document.body).scrollspy({target: '.sidebar', offset: $('.navbar').outerHeight(true)});
  var $sideBar = $('.single-page .sidebar');
  $sideBar.affix({
    offset: {
      top: function () { return this.top = $sideBar.offset().top - $('.docs-nav').height() - 30 }
    }
  })
});

$(document).ready(function() {
  $(window).scroll(function(){
    if ($(this).scrollTop() > 1500) {
      $('#scroll-to-top').removeClass('hidden').affix({
        offset: { top:100 }
      });
    } else {
      $('#scroll-to-top').addClass('hidden')
    }
  });
  
  $("#scroll-to-top").click(function(){
    $('html, body').animate({scrollTop : 0},500);
    return false;
  });
});