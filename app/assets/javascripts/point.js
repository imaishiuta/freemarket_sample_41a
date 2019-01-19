/*$(function() {
  function buildHTML() {
    if(value > price){
      html = `<div class="btn-default btn-red">
                ポイントが不足しています。
              </div>`
    } else if(value > point) {
      html = `<div class="btn-default btn-red">
                それ以上のポイントは使用できません。
              </div>`
    } else if(value <= $(this).data('point') || value <= price) {
      html = `<button class="btn-default btn-red", type="submit">
                <div class="buy-botton">購入する</div>
              </button>`
    }
    return html
  }

  $("#point").on("keyup", function(e) {
    e.preventDefault()
    var price = Number($(".buy-product-price-hidden").text())
    var value = Number($(this).val())
    var point = Number($(this).data('point'))
    var usable_point = point - value
    var sell_price = price - value
    if(sell_price >= 0 && usable_point >= 0) {
      $(".buy-price-cell-fix").text("")
      $(".buy-price-cell-fix").text(sell_price)
      $(".point").text("")
      $(".point").text(usable_point)
      } else {
      $(".buy-price-cell-fix").text("0")
      $(".point").text("0")
      }
      html = buildHTML()
      $(".button-wrapper").append(html)
  });
});*/
