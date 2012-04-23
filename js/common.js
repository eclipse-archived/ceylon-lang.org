//Put the footer at the bottom event for small content
var primaryContentHeight = 0;
var footerOffsetBottom = 0;

function footerGravity() {
  var correction = $(window).height() - footerOffsetBottom;
  if (correction > 0) {
    $('#primary-content').css('min-height', primaryContentHeight + correction);
  }
}

$(function() {
  primaryContentHeight = $('#primary-content').height();
  footerOffsetBottom = $('.footer-bar').outerHeight() + $('.footer-bar').offset().top;
  footerGravity();
  $(window).resize(footerGravity);
});