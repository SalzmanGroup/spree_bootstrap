$ ->
  $('.ellipsis').ellipsis({
      setTitle: true
  })

  $('#product_sort').on 'change', ->
  	window.location.href = "?sort=" + $(this).val(); 

  $('.select-span9').addClass('span9')

  $('#bstate .select-required').attr('style', '').addClass('span9')