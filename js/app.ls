/**
 * User: pilagod
 * Date: 7/10/15
 * Time: 10:29 PM
 */

require! 'react': React
require! './components/TodoApp-React': TodoApp

React.render do
	``<TodoApp />``
	document.get-element-by-id 'todoapp'
