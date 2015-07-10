/**
 * User: pilagod
 * Date: 7/10/15
 * Time: 4:55 PM
 */
require! 'react': React
require! '../actions/TodoActions'
require! './TodoTextInput-React': Todo-text-input
require! 'react/lib/cx'

React-prop-types = React.Prop-types

Todo-item = React.create-class do

	prop-types: do
		todo: React-prop-types.object.is-required

	get-initial-state: !->
		return is-editing: false

	/**
	 * @return {object}
	 */
	render: !->
		var input
		todo = @props.todo

		if @state.is-editing
			input = ``(
				<TodoTextInput
					className = "edit"
					onSave = {this._onSave}
					value = {todo.text}
				/>
			)``

		return ``(
			<li
				className = {cx({
					'completed': todo.complete,
					'editing': this.state.isEditing
				})}
				key = {todo.id}>
				<div className = "view">
					<input
						className = "toggle"
						type = "checkbox"
						checked = {todo.complete}
						onChange = {this._onToggleComplete}
					/>
					<label onDoubleClick = {this._onDoubleClick}>
						{todo.text}
					</label>
					<button className = "destroy" onClick = {this._onDestroyClick} />
				</div>
				{input}
			</li>
		)``

	_on-toggle-complete: !->
		Todo-actions.toggle-complete @props.todo

	_on-double-click: !->
		@set-state is-editing: true

	/**
   * Event handler called within TodoTextInput.
   * Defining this here allows TodoTextInput to be used in multiple places
   * in different ways.
   * @param  {string} text
   */
	_on-save: (text) !->
		Todo-actions.update-text @props.todo.id, text
		@set-state is-editing: false

	_on-destroy-click: !->
		Todo-actions.destroy @props.todo.id

module.exports = Todo-item