$ ->
  $('.ellipsis').ellipsis({
      setTitle: true
  })

  $('#product_sort').on 'change', ->
  	window.location.href = "?sort=" + $(this).val(); 