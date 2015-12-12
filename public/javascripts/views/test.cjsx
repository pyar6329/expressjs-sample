React = require('react')
ReactDOM = require('react-dom')

console.log 'cjsx'

class RadComponent extends React.Component
  render: ->
    <div>
      Hello React!!!!!!!!
    </div>

React.render(React.createFactory(RadComponent)(), document.getElementById('test'))
