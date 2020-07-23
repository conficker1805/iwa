window.Utils = {
  triggerOnClick(wrap = 'body', callback = () => {}){
    $.each($(wrap + ' .jstrigger[data-click]'), (i, input) => {
      $(input).on( 'click', () => {
        $( $(input).data('click') ).trigger('click')

        callback(input)
      })
    })
  }
}
