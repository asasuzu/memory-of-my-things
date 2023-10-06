import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['fileUpload']

  dragover(e) {
    e.preventDefault()
  }

  drop(e) {
    e.preventDefault()

    const files = e.dataTransfer.files
    if (files.length > 0) {
      const file = files[0]
      const allowedExtensions = ["jpeg", "jpg", "png", "gif"]
      const fileExtension = file.name.split('.').pop().toLowerCase()
      
      if (allowedExtensions.includes(fileExtension) && file.type.startsWith("image/")) {
        this.fileUploadTarget.files = files
      } else {
        // 許可されている画像ファイル以外をドロップした場合の処理
        alert("画像ファイル（jpegまたはpng）をアップロードしてください。")
      }
    }
  }
}