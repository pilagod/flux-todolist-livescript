/**
 * User: pilagod
 * Date: 7/9/15
 * Time: 11:58 PM
 */

require! '../dispatcher/AppDispatcher'
(require! 'events': EventEmitter).EventEmitter
require! '../constants/TodoConstants'
require! 'object-assign': assign

CHANGE_EVENT = 'change'

_todos = {}

/**
 * Create a TODO item.
 * @param  {string} text The content of the TODO
 */
create = (text) !->
  id = (+new Date! + Math.floor Math.random! * 999999).toString(36)
  _todos[id] =
    id: id
    complete: false
    text: text

/**
 * Update a TODO item.
 * @param  {string} id
 * @param {object} updates An object literal containing only the data to be
 *     updated.
 */
update = (id, updates) !->
  _todos[id] = assign {}, _todos[id], updates

/**
 * Update all of the TODO items with the same object.
 *     the data to be updated.  Used to mark all TODOs as completed.
 * @param  {object} updates An object literal containing only the data to be
 *     updated.
 */
updateAll = (updates) !->
  for id in Object.keys _todos
    update id, updates

/**
 * Delete a TODO item.
 * @param  {string} id
 */
destroy = (id) !->
  delete! _todos[id]

/**
 * Delete all the completed TODO items.
 */
destroyCompeleted = !->
  for id in Object.keys _todos
    if _todos[id].complete
      destroy id



TodoStore = assign {}, EventEmitter.prototype, do
  /**
   * Tests whether all the remaining TODO items are marked as completed.
   * @return {boolean}
   */
  areAllComplete: !->
    for id in Object.keys _todos
      if !_todos[id].complete
        return false
    return true

  /**
   * Get the entire collection of TODOs.
   * @return {object}
   */
  getAll: !->
    return _todos

  emitChange: !->
    @emit CHANGE_EVENT

  /**
   * @param {function} callback
   */
  addChangeListener: (callback) !->
    @on CHANGE_EVENT, callback


AppDispatcher.register (action) !->
  var text

  switch action.actionType
    case TodoConstants.TODO_CREATE
      text = action.text.trim!
      if text != ''
        create text
        TodoStore.emitChange!
      break

    case TodoConstants.TODO_TOGGLE_COMPLETE_ALL
      if TodoStore.areAllComplete!
        updateAll complete:false
      else
        updateAll complete:true

      TodoStore.emitChange!
      break

    case TodoConstants.TODO_UNDO_COMPLETE
      update action.id, complete:false
      TodoStore.emitChange!
      break

    case TodoConstants.TODO_COMPLETE
      update action.id, complete:true
      TodoStore.emitChange!
      break

    case TodoConstants.TODO_UPDATE_TEXT
      text = action.text.trim!
      if text != ''
        update action.id, text:text
        TodoStore.emitChange!
      break

    case TodoConstants.TODO_DESTROY
      destroy action.id
      TodoStore.emitChange!
      break

    case TodoConstants.TODO_DESTROY_COMPLETED
      destroyCompeleted!
      TodoConstants.emitChange!
      break

    default

module.exports = TodoStore

















