{CompositeDisposable} = require 'atom'

module.exports = DuplicateRemoval =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'duplicate-removal:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
    # pass

  remove_dup: (str) ->
    dict = []
    new_str = ""

    for line in str.split("\n")
      new_str += line + "\n" if not dict[line] and line isnt ""
      dict[line] = line

    return new_str

  toggle: ->
    editor = atom.workspace.getActiveTextEditor()
    buf = editor.getBuffer()
    buf.setText(@remove_dup buf.getText())
