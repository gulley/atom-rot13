module.exports =
  activate: ->
    atom.workspaceView.command "rot13:convert", => @convert()

  convert: ->
    editor = atom.workspace.activePaneItem

    rot13 = (str) -> str.replace(/[a-zA-Z]/g, (c) -> String.fromCharCode(c.charCodeAt(0) + if (c.toLowerCase().charCodeAt(0) < 110) then 13 else -13))

    selectionsRanges = editor.getSelectedBufferRanges()

    editor.setTextInBufferRange(range, rot13(editor.getTextInBufferRange(range))) for range in selectionsRanges
