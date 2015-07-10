/**
 * User: pilagod
 * Date: 7/10/15
 * Time: 12:16 PM
 */

require! 'react': React
require! '../actions/TodoActions'

React-prop-types = React.Prop-types

Footer = React.create-class do

	prop-types: do
		allTodos: React-prop-types.object.is-required

	render: !->
		all-todos = @props.all-todos
		total = Object.keys all-todos .length

		if total == 0
			return null

		completed = 0
		for todo in all-todos
			if todo.complete
				completed++

		items-left = total - completed
		items-left-phrase = if items-left == 1
												then ' item '
												else ' items '
		items-left-phrase += 'left'

		var clear-completed-button
		if completed
			clear-completed-button = do
				``(
				<Button
					id = "clear-completed"
					onClick = {this._OnClickCompletedClick}>
					Clear completed ({completed})
				</Button>
				)``
		return ``(
			<footer id = "footer">
				<span id = "todo-count">
					<strong>
						{itemsLeft}
					</strong>
					{itemsLeftPhrase}
				</span>
				{clearCompletedButton}
			</footer>
		)``

	_on-clear-completed-click: !->
		TodoActions.destroyCompleted!

module.exports = Footer