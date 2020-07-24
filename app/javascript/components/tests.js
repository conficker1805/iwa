window.Iwa.tests = {
  initNew(){
    this.addCocoonDefautEvents()
  },

  initEdit(){
    this.addCocoonDefautEvents()
  },

  addCocoonDefautEvents(){
    Utils.triggerOnClick()
    $('.cocoon-property').on('cocoon:after-insert', function(event, insertedItem) {
      $(insertedItem).find('.add-option').trigger('click')
    })
  }
}
