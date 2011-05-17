(function ($) {
  $("a[role*=popup]").livequery(function() {
    $(this).facebox();
  });

  $("#edit-actions [title]").livequery(function() {
    $(this).tipTip({
      delay: 0, edgeOffset: 5, fadeIn: 100, maxWidth: "300px", defaultPosition: "right"
    });
  });
})(jQuery);
