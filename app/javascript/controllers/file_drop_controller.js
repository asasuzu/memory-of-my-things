// app/javascript/controllers/file_drop_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['fileUpload']

  dragover(e) {
    e.preventDefault()
  }

  drop(e) {
    e.preventDefault()

    const files = e.dataTransfer.files
    if (typeof files[0] !== 'undefined') {
      this.fileUploadTarget.files = files
    }
  }
}