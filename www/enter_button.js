$(document).keyup(function(event) {
    if ($("#userName").is(":focus") && $("#passwd").is(":focus") && (event.keyCode == 13)) {
      $("#Login").click();
    }
  });