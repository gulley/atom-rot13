{CompositeDisposable} = require 'atom'

module.exports =
  activate: ->
    # atom.workspaceView.command "rot13:convert", => @convert()
    # atom.views.getView(atom.workspace).command "rot13:convert", => @convert()

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'rot13:convert': => @convert()

  deactivate: ->
    @subscriptions.dispose()

  convert: ->
    editor = atom.workspace.getActiveTextEditor()

    rot13 = (str) -> str.replace(/[a-zA-Z]/g, (c) -> String.fromCharCode(c.charCodeAt(0) + if (c.toLowerCase().charCodeAt(0) < 110) then 13 else -13))

    selectionsRanges = editor.getSelectedBufferRanges()

    editor.setTextInBufferRange(range, rot13(editor.getTextInBufferRange(range))) for range in selectionsRanges
