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
  	$('#main-image #img_container img').attr 'src', $(this).attr('href')

  $('#img_container').zoom()

  $('#product-variants select').on 'change', update_cart_button_text
  update_cart_button_text()


update_cart_button_text = ->
  selected_variant = $('#product-variants select :selected')
  cart_button = $('#add-to-cart-button')

  if selected_variant.length
    if selected_variant.data('stock') == "in_stock"
      updated_text = "Add To Cart"
      disable_button = false
    else if selected_variant.data('stock') == "preorder"
      updated_text = "Preorder"
      disable_button = false
    else
      updated_text = "Out of Stock"
      disable_button = true

    cart_button.attr 'disabled', disable_button
    cart_button.text updated_text
    $('[itemprop="price"]').text "$" + selected_variant.data('price').toFixed(2)


    if $('#collapse_container').height() > 150
        $('#collapse_container').addClass('collapsed')

        
    $('#collapse_container a').on 'click', (e) =>
        e.preventDefault()
        $('#collapse_container').toggleClass('collapsed', 500)

