/**
 * User: pilagod
 * Date: 7/10/15
 * Time: 4:23 PM
 */

require! 'react': React
require! '../actions/TodoActions'
require! './TodoTextInput-React': TodoTextInput

Header = React.create-class do
	/**
	 *  @return {object}
	 */
	render: !->
		return ``(
			<header id="header">
				<h1>todos</h1>
				<TodoTextInput
					id="new-todo"
					placeholder="What needs to be done?"
					onSave={this._onSave}
				/>
			</header>
		)``

	/*
	 * @param {string} text
	 */
	_on-save: (text) !->
		if text.trim!
			TodoActions.create text

module.exports = Header