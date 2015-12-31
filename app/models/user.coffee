# passport、local strageの設定
mongoose = require 'mongoose'
Schema = mongoose.Schema
# require 'passport-local-mongoose'

UserSchema = new Schema
  id: String
  email: String
  admin: Boolean
  headers:
    client: String
    expiry: Number
    uid: String
    'access-token': String
    'token-type': String

module.exports = mongoose.model('User', UserSchema)
