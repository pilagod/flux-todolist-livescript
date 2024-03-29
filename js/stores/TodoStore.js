// Generated by LiveScript 1.4.0
/**
 * User: pilagod
 * Date: 7/9/15
 * Time: 11:58 PM
 */
(function(){
  var AppDispatcher, EventEmitter, TodoConstants, assign, CHANGE_EVENT, _todos, create, update, updateAll, destroy, destroyCompeleted, TodoStore;
  AppDispatcher = require('../dispatcher/AppDispatcher');
  EventEmitter = require('events').EventEmitter;
  TodoConstants = require('../constants/TodoConstants');
  assign = require('object-assign');
  CHANGE_EVENT = 'change';
  _todos = {};
  /**
   * Create a TODO item.
   * @param  {string} text The content of the TODO
   */
  create = function(text){
    var id;
    id = (+new Date() + Math.floor(Math.random() * 999999)).toString(36);
    _todos[id] = {
      id: id,
      complete: false,
      text: text
    };
  };
  /**
   * Update a TODO item.
   * @param  {string} id
   * @param {object} updates An object literal containing only the data to be
   *     updated.
   */
  update = function(id, updates){
    _todos[id] = assign({}, _todos[id], updates);
  };
  /**
   * Update all of the TODO items with the same object.
   *     the data to be updated.  Used to mark all TODOs as completed.
   * @param  {object} updates An object literal containing only the data to be
   *     updated.
   */
  updateAll = function(updates){
    var i$, ref$, len$, id;
    for (i$ = 0, len$ = (ref$ = Object.keys(_todos)).length; i$ < len$; ++i$) {
      id = ref$[i$];
      update(id, updates);
    }
  };
  /**
   * Delete a TODO item.
   * @param  {string} id
   */
  destroy = function(id){
    delete _todos[id];
  };
  /**
   * Delete all the completed TODO items.
   */
  destroyCompeleted = function(){
    var i$, ref$, len$, id;
    for (i$ = 0, len$ = (ref$ = Object.keys(_todos)).length; i$ < len$; ++i$) {
      id = ref$[i$];
      if (_todos[id].complete) {
        destroy(id);
      }
    }
  };
  TodoStore = assign({}, EventEmitter.prototype, {
    /**
     * Tests whether all the remaining TODO items are marked as completed.
     * @return {boolean}
     */
    areAllComplete: function(){
      var i$, ref$, len$, id;
      for (i$ = 0, len$ = (ref$ = Object.keys(_todos)).length; i$ < len$; ++i$) {
        id = ref$[i$];
        if (!_todos[id].complete) {
          return false;
        }
      }
      return true;
    }
    /**
     * Get the entire collection of TODOs.
     * @return {object}
     */,
    getAll: function(){
      return _todos;
    },
    emitChange: function(){
      this.emit(CHANGE_EVENT);
    }
    /**
     * @param {function} callback
     */,
    addChangeListener: function(callback){
      this.on(CHANGE_EVENT, callback);
    }
  });
  AppDispatcher.register(function(action){
    var text;
    switch (action.actionType) {
    case TodoConstants.TODO_CREATE:
      text = action.text.trim();
      if (text !== '') {
        create(text);
        TodoStore.emitChange();
      }
      break;
    case TodoConstants.TODO_TOGGLE_COMPLETE_ALL:
      if (TodoStore.areAllComplete()) {
        updateAll({
          complete: false
        });
      } else {
        updateAll({
          complete: true
        });
      }
      TodoStore.emitChange();
      break;
    case TodoConstants.TODO_UNDO_COMPLETE:
      update(action.id, {
        complete: false
      });
      TodoStore.emitChange();
      break;
    case TodoConstants.TODO_COMPLETE:
      update(action.id, {
        complete: true
      });
      TodoStore.emitChange();
      break;
    case TodoConstants.TODO_UPDATE_TEXT:
      text = action.text.trim();
      if (text !== '') {
        update(action.id, {
          text: text
        });
        TodoStore.emitChange();
      }
      break;
    case TodoConstants.TODO_DESTROY:
      destroy(action.id);
      TodoStore.emitChange();
      break;
    case TodoConstants.TODO_DESTROY_COMPLETED:
      destroyCompeleted();
      TodoConstants.emitChange();
      break;
    default:

    }
  });
  module.exports = TodoStore;
}).call(this);
