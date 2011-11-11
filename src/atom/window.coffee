fs = require 'fs'
_ = require 'underscore'

# This a weirdo file. We don't create a Window class, we just add stuff to
# the DOM window.
windowAdditions =
  url: null

  startup: ->
    @url = $atomController.url?.toString()
    $atomController.window.makeKeyWindow

  shutdown: ->

  showConsole: ->
    $atomController.webView.inspector.showConsole true

  setTitle: (title) ->
    $atomController.window.title = title

  reload: ->
    @close()
    OSX.NSApp.createController @url

  open: (url) ->
    url = atom.native.openPanel() unless url
    (atom.document.open url) or atom.app.open url

  close: (url) ->
    @shutdown()
    $atomController.close

  handleKeyEvent: ->
    atom.keybinder.handleEvent arguments...

  triggerEvent: ->
    atom.trigger arguments...

for key, value of windowAdditions
  console.warn "DOMWindow already has a key named `#{key}`" if window[key]
  window[key] = value
