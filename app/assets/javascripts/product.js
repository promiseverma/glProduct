if(document.cookie != ""){
    $("#items").html(document.cookie.split("=")[1].split(",").length);
  }

  var goForCheckout = function (){
    $("#products_list").val(document.cookie.split("=")[1].split(","));
  }

  var createCookie = function(product, id, days) {
    var expires;
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    }
    else {
        expires = "";
    }
    arr = [];
    if(document.cookie != "" && document.cookie.split("=").length > 1){
      arr.push(document.cookie.split("=")[1]);
    }

    arr.push(id);
    if(document.cookie == "product="){
      document.cookie = arr;
    }
    else{
    document.cookie = product + "=" + arr;
    }

    $("#items").html(document.cookie.split("=")[1].split(",").length);
}
