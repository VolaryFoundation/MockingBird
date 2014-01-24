$(document).ready(function() {
  $("a.edit_link", $('section#mockingbird_view')).click(function(e) {
	e.preventDefault();
	$('section#mockingbird_view').hide();
	$('section#mockingbird_edit').show();
  })

  $("a.cancel", $('section#mockingbird_edit')).click(function(e) {
	e.preventDefault();
	$('section#mockingbird_view').show();
	$('section#mockingbird_edit').hide();
	 $("form#submit_groups")[0].reset()
  })
  $(function() {
    $("form#submit_groups").submit(function(e){
      e.preventDefault();
  
      $.ajax({
        type: "POST",
        url: "/api/groups/" + $("form#submit_groups").attr('action'),
        data: $('form#submit_groups').serialize(),
        success: function(data){
          data = JSON.parse(data);
          detailsUL = $('ul.mocking_bird_details')
          //Update Location
          locationLI = $('li.location', detailsUL)
          $('span.text', locationLI).text(locationHelper(data.location))
          //Update range
          rangeLI = $('li.range', detailsUL)
          $('span.text', rangeLI).text(data.range)
		  //Update name
          nameLI = $('li.name', detailsUL)
          $('span.text', nameLI).text(data.name)
		//Update tags
          descriptionLI = $('li.description', detailsUL)
          $('span.text', descriptionLI).text(data.description)
          //Update tags
          tagsLI = $('li.tags', detailsUL)
          $('span.text', tagsLI).text(data.tags.join(", "))
		  $('section#mockingbird_view').show();
		  $('section#mockingbird_edit').hide();
        },
        error: function(data){
          alert("Failure: " + data)
        }
      });
    });
  });
})

function locationHelper(locationObject) {
	var locationArray = []
	if (locationObject.address != null && locationObject.address != "") {
		locationArray.push(locationObject.address)
	}
	if (locationObject.city != null && locationObject.address != "") {
		locationArray.push(locationObject.city)
	}
	if (locationObject.state != null && locationObject.address != "") {
		locationArray.push(locationObject.state)
	}
	if (locationObject.postal_code != null && locationObject.address != "") {
		locationArray.push(locationObject.postal_code)
	}
	if (locationObject.country != null && locationObject.address != "") {
		locationArray.push(locationObject.country)
	}
	return locationArray.join(', ')
};