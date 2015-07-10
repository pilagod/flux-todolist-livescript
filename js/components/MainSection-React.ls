/**
 * User: pilagod
 * Date: 7/10/15
 * Time: 6:51 PM
 */

require! 'react': React
require! '../actions/TodoActions'
require! './TodoItem-React': Todo-item
React-prop-types = React.Prop-types

Main-section = React.create-class do

	prop-types:
		all-todos: React-prop-types.object.is-required
		are-all-complete: React-prop-types.bool.is-required

	/**
	 * @return {object}
	 */
	render: !->
		if Object.keys @props.all-todos .length < 1
				return null

		all-todos = @props.all-todos
		todos = []

		for key in Object.keys all-todos
			todos.push `` <TodoItem key={key} todo={allTodos[key]} /> ``

		return ``(
			<section id="main">
				<input
					id="toggle-all"
					type="checkbox"
					onChange={this._onToggleCompleteAll}
					checked={this.props.areAllComplete ? 'checked' : ''}
				/>
				<label htmlFor="toggle-all">Mark all as complete</label>
				<ul id="todo-list">{todos}</ul>
			</section>
		)``

	/**
   * Event handler to mark all TODOs as complete
   */
	_on-toggle-complete-all: !->
		Todo-actions.toggle-complete-all!

module.exports = MainSection
