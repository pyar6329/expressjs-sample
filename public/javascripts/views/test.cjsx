React = require('react')
ReactDOM = require('react-dom')

class CommentBox extends React.Component
  render: ->
    <div className="CommentBox">
      ooooooooooooReact fooooooooooooosssssss!!!!!!!!
    </div>

module.exports = CommentBox

# window.onload = ( ->
#   ReactDOM.render(
#     # <CommentBox />
#     React.createElement(CommentBox, null),
#     document.getElementById('test')
#   )
# )
