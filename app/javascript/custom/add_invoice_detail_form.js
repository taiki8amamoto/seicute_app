document.getElementById("add-invoice-detail-form").addEventListener("click", function() {
  var container = document.getElementById("invoice-details");
  var invoiceDetails = container.getElementsByClassName("invoice-detail");
  
  // 非表示のフォームを検索し、最初の非表示フォームを表示する
  for (var i = 0; i < invoiceDetails.length; i++) {
    if (invoiceDetails[i].style.display === "none") {
      invoiceDetails[i].style.display = "flex";
      break;
    }
  }
});
