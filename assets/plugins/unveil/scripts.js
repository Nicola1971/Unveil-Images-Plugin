$(document).ready(function() {
$("img").unveil(200, function() {
  $(this).load(function() {
    this.style.opacity = 1;
  });
});
});