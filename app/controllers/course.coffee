express = require('express')
router = express.Router()

### GET home page. ###

router.get '/', (req, res, next) ->
  res.render 'course/index'
  return
module.exports = router
