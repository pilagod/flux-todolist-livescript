/**
 * User: pilagod
 * Date: 7/10/15
 * Time: 10:22 PM
 */

require! './Footer-React': Footer
require! './Header-React': Header
require! './MainSection-React': MainSection
require! 'react': React
require! '../stores/TodoStore'

get-todo-state = !->
	return
		all-todos: Todo-store.get-all!
		are-all-complete: Todo-store.are-all-complete!

Todo-app = React.create-class do

	get-initial-state: !->
		return get-todo-state!

	component-did-mount: !->
		Todo-store.add-change-listener @_on-change

	component-will-unmount: !->
		Todo-store.remove-change-listener @_on-change

	/**
   * @return {object}
   */
	render: !->
		return ``(
			<div>
				<Header />
				<MainSection
					allTodos = {this.state.allTodos}
					areAllComplete = {this.state.areAllComplete}
				/>
				<Footer allTodos = {this.state.allTodos} />
			</div>
		)``

	/**
   * Event handler for 'change' events coming from the TodoStore
   */
	_on-change: !->
		@set-state get-todo-state

module.exports = Todo-app