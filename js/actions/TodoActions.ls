require! '../dispatcher/AppDispatcher'
require! '../constants/TodoConstants'

TodoActions = do
	/**
   * @param  {string} text
   */
	create: (text) !->
		AppDispatcher.dispatch do
			actionType: TodoConstants.TODO_CREATE
			text: text

	/**
   * @param  {string} id The ID of the ToDo item
   * @param  {string} text
   */
	updateText: (id, text) !->
		AppDispatcher.dispatch do
			actionType: TodoConstants.TODO_UPDATE_TEXT
			id: id
			text: text

	/**
   * Toggle whether a single ToDo is complete
   * @param  {object} todo
   */
	toggleComplete: (todo) !->
		id = todo.id
		actionType = if todo.complete then TodoConstants.TODO_UNDO_COMPLETE else TodoConstants.TODO_COMPLETE

		AppDispatcher.dispatch do
			actionType: actionType
			id: id


	/**
   * Mark all ToDos as complete
   */
	toggleCompleteAll: !->
		AppDispatcher.dispatch do
			actionType: TodoConstants.TODO_TOGGLE_COMPLETE_ALL

	/**
   * @param  {string} id
   */
	destroy: (id) !->
		AppDispatcher.dispatch do
			actionType: TodoConstants.TODO_DESTROY
			id: id


	/**
   * Delete all the completed ToDos
   */
	destroyCompleted: !->
		AppDispatcher.dispatch do
			actionType: TodoConstants.TODO_DESTROY_COMPLETED

module.exports = TodoActions


