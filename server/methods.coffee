cl = console.log
HTTP.methods
  'removeFiles': (data) ->
    cl data.DEL_FILE_LIST
    fs.unlinkSync
#    return throw new Meteor.Error 'test error'
    return 'success'

#Meteor.methods
#  'removeFiles': (DEL_FILE_LIST) ->
#    cl 'remove files'
#    cl DEL_FILE_LIST
#    return 'success'
##    return throw new Meteor.Error 'error 123123'