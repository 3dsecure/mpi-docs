$(function() {
  var toc = $("#toc").tocify({
    context: "section#doc-content",
    selectors: "h1, h2",
    showAndHide: false
  });

  $('a[data-toc]').on('click', function(ev){
    ev.preventDefault();
    var hash = $(ev.currentTarget).data('toc');
    var elem = $('#toc').find("li[data-unique='" + hash + "']");

    if(elem.length){
      elem.click();
    }
  })

  $('table', $('#doc-content')).each(function () {
    $(this).addClass("table table-condensed");
  });
});
