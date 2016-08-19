cl = console.log
HTTP.methods
  'test': (data) ->
    cl data
    return 'success'

Meteor.methods
  'removeFiles': (DEL_FILE_LIST) ->
    cl 'remove files'
    cl DEL_FILE_LIST
    return 'success'
#    return throw new Meteor.Error 'error 123123'