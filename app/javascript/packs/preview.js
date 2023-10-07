document.addEventListener("turbolinks:load", function() {
  const fileInput = document.querySelector('input[type="file"]');
  const imagePreview = document.getElementById('image-preview');
  const fileNamePreview = document.getElementById('file-name-preview');

  fileInput.addEventListener('change', function (event) {
    const file = event.target.files[0];
    if (file) {
      const fileExtension = file.name.split('.').pop().toLowerCase();
      const allowedExtensions = ["jpeg", "jpg", "png", "gif"];

      if (allowedExtensions.includes(fileExtension) && file.type.startsWith("image/")) {
        const reader = new FileReader();
        reader.onload = function (e) {
          imagePreview.src = e.target.result;
          imagePreview.style.display = 'block';
          fileNamePreview.innerText = file.name;
        };
        reader.readAsDataURL(file);
      } else {
        // 許可されていないファイル形式の場合の処理
        alert("画像ファイル（jpegまたはpng）を選択してください。");
        fileInput.value = '';
        imagePreview.src = '';
        imagePreview.style.display = 'none';
        fileNamePreview.innerText = '';
      }
    }
  });
});