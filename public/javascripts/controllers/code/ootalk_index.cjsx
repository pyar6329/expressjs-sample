crypto = require 'crypto'

Node = (operator, left, right, middle) ->
  newNode = {}
  idsource = (new Date).toTimeString() + operator + left
  newNode[operator] = {}
  newNode[operator].Left = left
  if right != 'undefined'
    idsource += right
    newNode[operator].Right = right
  if middle != 'undefined'
    idsource += middle
    newNode[operator].Middle = middle
  hash = crypto.createHash('sha1')
  hash.update idsource
  nodeid = hash.digest('hex')
  newNode.nodeid = nodeid
  newNode.createdAt = new Date
  newNode

_Tree = []
OoTalk =
  version: '0.1.2'
  init: ->
    _Tree = []
    return
  reset: ->
    @init()
    return
  newNode: (operator, left, right, middle) ->
    new Node(operator, left, right, middle)
  append: (node) ->
    _Tree.push node
    return
  insert: (atIndex, node) ->
    _Tree.splice atIndex, 0, node
    return
  modify: (nodeid, node) ->
    result = @_searchNodeInternal(nodeid)
    if result != null
      if result.parentObject != null
        elem = result.element
        result.parentObject[Object.keys(result.parentObject)[0]][elem] = node
        _Tree[result.nodeIndex] = result.root
      else
        _Tree[result.nodeIndex] = node
    return
  remove: (nodeid) ->
    result = @_searchNodeInternal(nodeid)
    if result != null
      if result.parentObject != null
        elem = result.element
        result.parentObject[Object.keys(result.parentObject)[0]][elem] = null
        _Tree[result.nodeIndex] = result.root
      else
        _Tree.splice result.nodeIndex, 1
    return
  tree: ->
    _Tree
  searchNode: (nodeid) ->
    @_searchNodeInternal nodeid, false
  _searchNodeInternal: (nodeid, needsNodeInfo) ->
    if needsNodeInfo == undefined
      needsNodeInfo = true
    result = null
    i = 0
    while i < _Tree.length
      node = _Tree[i]
      if node.nodeid == nodeid
        if needsNodeInfo == false
          return node
        result = {}
        result.parentObject = null
        result.node = node
        result.nodeIndex = i
        result.root = node
        break
      result = @_searchObjectRecursive(node, nodeid, i)
      if result != null
        if needsNodeInfo == false
          return result.node
        result.root = node
        break
      i++
    result
  _searchObjectRecursive: (node, nodeid, index) ->
    key = Object.keys(node)[0]
    element = node[key]
    for elemKey of element
      if element.hasOwnProperty(elemKey)
        obj = element[elemKey]
        if typeof obj == 'object'
          if obj.nodeid == nodeid
            return {
              element: elemKey
              parentObject: node
              node: obj
              nodeIndex: index
            }
          n = @_searchObjectRecursive(obj, nodeid, index)
          if n != null
            return n
    null
module.exports = OoTalk
