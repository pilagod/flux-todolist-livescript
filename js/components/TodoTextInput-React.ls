/**
 * User: pilagod
 * Date: 7/10/15
 * Time: 4:25 PM
 */

require! 'react': React

React-prop-types = React.Prop-types

ENTER_KEY_CODE = 13

Todo-text-input = React.create-class do

	prop-types:
		class-name: React-prop-types.string
		id: React-prop-types.string
		placeholder: React-prop-types.string
		on-save: React-prop-types.func.is-required
		value: React-prop-types.string

	get-initial-state: !->
		return do
			value: @props.value || ''

	/**
   * @return {object}
   */
	render: !->
		return ``(
			<input
				className = {this.props.className}
				id = {this.props.id}
				placeholder = {this.props.placeholder}
				onBlur = {this._save}
				onChange = {this._onChange}
				onKeyDown = {this._onKeyDown}
				value = {this.state.value}
				autoFocus = {true}
			/>
		)``

	/**
   * Invokes the callback passed in as onSave, allowing this component to be
   * used in different ways.
   */
	_save: !->
		@props.on-save @state.value
		@set-state value: ''

	/**
   * @param {object} event
   */
	_on-change: (event) !->
		@set-state value: event.target.value

	/**
   * @param  {object} event
   */
	_on-key-down: (event) !->
		console.log event.key-code
		if event.key-code == ENTER_KEY_CODE
			console.log 'save'
			@_save!

module.exports = TodoTextInput


