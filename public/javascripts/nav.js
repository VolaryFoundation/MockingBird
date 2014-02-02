$(document).ready(function() {
	
  // Submit link as a post for logout (as well as claim and accept user on groups)
  $('a.act_as_form').click(function(e) {
	e.preventDefault();
	$.ajax({
      type: $(this).attr('_method'),
      url: $(this).attr('href'),
	  success: function(data){
		window.location.href = JSON.parse(data)
      },
      error: function(data){
      }
    })
  })

  //Nav dropdown menues.
  $('li.main_nav').hover(
	function(e) {
	  $(this).find('ul').show()
	}, function(e) {
	  $(this).find('ul').hide()
	})
})