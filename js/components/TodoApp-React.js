// Generated by LiveScript 1.4.0
/**
 * User: pilagod
 * Date: 7/10/15
 * Time: 10:22 PM
 */
(function(){
  var Footer, Header, MainSection, React, TodoStore, getTodoState, TodoApp;
  Footer = require('./Footer-React');
  Header = require('./Header-React');
  MainSection = require('./MainSection-React');
  React = require('react');
  TodoStore = require('../stores/TodoStore');
  getTodoState = function(){
    return {
      allTodos: TodoStore.getAll(),
      areAllComplete: TodoStore.areAllComplete()
    };
  };
  TodoApp = React.createClass({
    getInitialState: function(){
      return getTodoState();
    },
    componentDidMount: function(){
      TodoStore.addChangeListener(this._onChange);
    },
    componentWillUnmount: function(){
      TodoStore.removeChangeListener(this._onChange);
    }
    /**
      * @return {object}
      */,
    render: function(){
      return (
      	<div>
      		<Header />
      		<MainSection
      			allTodos = {this.state.allTodos}
      			areAllComplete = {this.state.areAllComplete}
      		/>
      		<Footer allTodos = {this.state.allTodos} />
      	</div>
      );
    }
    /**
      * Event handler for 'change' events coming from the TodoStore
      */,
    _onChange: function(){
      this.setState(getTodoState);
    }
  });
  module.exports = TodoApp;
}).call(this);
