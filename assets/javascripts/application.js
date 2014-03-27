$(function() {
  $(".menu-link").hover(
    function() { $("#subtitle").text($(this).text()); },
    function() { $("#subtitle").text("~/"); }
  );
});
