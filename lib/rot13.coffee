{CompositeDisposable} = require 'atom'

module.exports =
  activate: ->
    # atom.workspaceView.command "rot13:convert", => @convert()
    # atom.views.getView(atom.workspace).command "rot13:convert", => @convert()

    # atom.workspaceView.command "rot13:ankify", => @ankify()
    # atom.views.getView(atom.workspace).command "rot13:ankify", => @ankify()

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'rot13:convert': => @convert()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'rot13:ankify': => @ankify()

  deactivate: ->
    @subscriptions.dispose()

  ankify: ->
    editor = atom.workspace.getActiveTextEditor()
    text = editor.getText()

    ank = (str) ->
      lines = str.split('\n')
      outstr = ''
      i = 1
      while i<lines.length
        outstr += lines[i-1].trim() + '\\' + lines[i].trim() + '\n'
        i++
      outstr

    editor.setText(ank(text))

  convert: ->
    editor = atom.workspace.getActiveTextEditor()

    rot13 = (str) -> str.replace(/[a-zA-Z]/g, (c) -> String.fromCharCode(c.charCodeAt(0) + if (c.toLowerCase().charCodeAt(0) < 110) then 13 else -13))

    # Replace ALL the text with the ROT13 cipher
    editor.setText(rot13(editor.getText()))
    # editor.setText('hello')
