document.getElementById("add-picture-form").addEventListener("click", function() {
  var container = document.getElementById("pictures");
  var pictures = container.getElementsByClassName("picture");
  
  // 非表示のフォームを検索し、最初の非表示フォームを表示する
  for (var i = 0; i < pictures.length; i++) {
    if (pictures[i].style.display === "none") {
      pictures[i].style.display = "flex";
      break;
    }
  }
});
