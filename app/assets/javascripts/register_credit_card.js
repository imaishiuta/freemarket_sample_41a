$(function() {
  $("#payment_card_no").on("input", function(){
    var value = $(this).val()
    var length = value.length
    var maxlength = $(this).attr('maxlength')
    if (length > maxlength) {
      this.value = value.slice(0, maxlength);
    }
  })
  $("#payment_card_security_code").on("input", function(){
    var value = $(this).val()
    console.log(value)
    var length = value.length
    var maxlength = $(this).attr('maxlength')
    if (length > maxlength) {
      this.value = value.slice(0, maxlength);
    }
  })
})
