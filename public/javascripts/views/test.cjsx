React = require('react')
ReactDOM = require('react-dom')

class CommentBox extends React.Component
  render: ->
    <div className="CommentBox">
      Hello React fooooooooooooosssssss!!!!!!!!
    </div>

window.onload = ( ->
  ReactDOM.render(
    <CommentBox />
    document.getElementById('test')
  )
)
