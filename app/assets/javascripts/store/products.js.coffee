$ ->
  $('.ellipsis').ellipsis({
      setTitle: true
  })

  $('#product_sort').on 'change', ->
  	window.location.href = "?sort=" + $(this).val(); 

  $('.select-span9').addClass('span9')

  $('#bstate .select-required').attr('style', '').addClass('span9')

  $('.product-thumbnail').off()
  $('.product-thumbnail a').on 'click', ->
  	console.log 'clicked'
  	return if $(this).closest('.product-thumbnail').hasClass 'selected'
  	console.log 'through'
  	$('#main-image img').attr 'src', $(this).attr('href')
  	$('#main-image img').attr('data-zoom', $(this).attr('data-zoom'))

  $('#main-image').zoom()