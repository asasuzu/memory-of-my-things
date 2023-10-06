// Load all the controllers within this directory and all subdirectories. 
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()

import FileDropController from './file_drop_controller'
application.register('file-drop', FileDropController)


const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))
