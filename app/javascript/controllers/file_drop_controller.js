import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['fileUpload', 'imagePreview', 'fileNamePreview']

  dragover(e) {
    e.preventDefault()
  }

  drop(e) {
    e.preventDefault()

    const files = e.dataTransfer.files
    if (files.length === 1) { // 1つのファイルだけを許可
      const file = files[0]
      const allowedExtensions = ["jpeg", "jpg", "png", "gif"]
      const fileExtension = file.name.split('.').pop().toLowerCase()

      if (allowedExtensions.includes(fileExtension) && file.type.startsWith("image/")) {
        // 許可されている画像ファイルをドロップした場合の処理
        this.fileUploadTarget.files = files
        this.displayPreview(file)
        this.displayFileName(file.name)
      } else {
        // 許可されている画像ファイル以外をドロップした場合の処理
        alert("画像ファイル（jpegまたはpng）を選択してください。")
      }
    } else {
      // 複数のファイルがドロップされた場合の処理
      alert("選択できるファイルは1つだけです。")
    }
  }

  displayPreview(file) {
    const reader = new FileReader()
    reader.onload = (e) => {
      this.imagePreviewTarget.src = e.target.result
      this.imagePreviewTarget.style.display = 'block'
    }
    reader.readAsDataURL(file)
  }

  displayFileName(fileName) {
    this.fileNamePreviewTarget.innerText = fileName
  }
}