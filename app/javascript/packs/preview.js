document.addEventListener("turbolinks:load", function() {
  const fileInput = document.querySelector('input[type="file"]');
  const imagePreview = document.getElementById('image-preview');
  const fileNamePreview = document.getElementById('file-name-preview');

  fileInput.addEventListener('change', handleFileInputChange);

  function handleFileInputChange(event) {
    const file = event.target.files[0];
    if (file) {
      const fileExtension = file.name.split('.').pop().toLowerCase();
      const allowedExtensions = ["jpeg", "jpg", "png", "gif"];

      if (allowedExtensions.includes(fileExtension) && file.type.startsWith("image/")) {
        displayPreview(file);
      } else {
        showError("画像ファイル（jpegまたはpng）を選択してください.");
        clearPreview();
      }
    } else {
      clearPreview();
    }
  }

  function displayPreview(file) {
    const reader = new FileReader();
    reader.onload = function (e) {
      imagePreview.src = e.target.result;
      imagePreview.style.display = 'block';
      fileNamePreview.innerText = file.name;
    };
    reader.readAsDataURL(file);
  }

  function showError(message) {
    alert(message);
    fileInput.value = '';
  }

  function clearPreview() {
    imagePreview.src = '';
    imagePreview.style.display = 'none';
    fileNamePreview.innerText = '';
  }
});
