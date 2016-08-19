cl = console.log
future = require 'fibers/future'
fiber = require 'fibers'
fs = require 'fs'

Meteor.startup ->
  dms = DDP.connect mSettings.DMS_URL

  while true    #ddp stream error에 대한 while 문의 timeout 반복 체크 테스트가 안됨.
    cl 'while??'
    #  dms에서 agent setting 부터 받아온다
    fut = new future()
    dms.call 'getAgentSetting', mSettings.AGENT_URL, (err, rslt) ->
      if err then cl err
      fut.return rslt
    setting = fut.wait()
    if setting? then break
    else Meteor._sleepForMs 5000
  cl 'end'


  #setting이 있어야 구동
  ### test data
  {
      "_id" : "nHQ2LXqtYFntnfDvt",
      "Agent명" : "dasAgent",
      "AGENT_URL" : "http://localhost:3000",
      "파일삭제기능" : true,
      "소멸정보전송기능" : true,
      "소멸정보절대경로" : "~/data",
      "서비스정보_id" : "oo48cjeTXPna6DK8J"
  }
  ###

  checkDir = ->
    path = setting.소멸정보절대경로
    files = fs.readdirSync(path)
    files.forEach (file) ->
  #    fut = new future()
      dasInfo = fs.readFileSync "#{path}/#{file}", 'utf-8'#, (err, str) ->
  #      fut.return str

  #    dasInfo = fut.wait()
      dms.call 'insertDAS', dasInfo, mSettings.AGENT_URL, (err, rslt) ->
        cl "!!!!!!!!!!!!!!!!!!!!!!!!!!##################################"
        cl err or rslt

  checkDir()
  setInterval ->
    fiber ->
      checkDir()
    .run()
  , 1000*3



  #dms.call 'insertDAS',
  #  Agent명: setting.agent.Agent명
  #  AGENT_URL: mSettings.AGENT_URL
  #  서비스_ID: 'SVC00001'    #파일에서 꺼냄
  #  게시판_ID: 'BRD00001'    #파일에서 꺼냄
  #  REQ_DATE: new Date('2016-08-15') #'201608151231000'
  #  CUR_IP: '10.0.0.24'
  #  DEL_FILE_LIST: [
  #    '/data/images/1.jpg'
  #    '/data/files/2.doc'
  #  ]
  #  UP_FSIZE: 3038920   #num type
  #  DEL_DATE: new Date('2016-08-20') #'201608201231000'
  #  KEEP_PERIOD: 10   #date 계산해서 넣어줌.
  #  STATUS: 'success'   # success or err_msg / delete error, sql error

  #dms.call 'insertDAS',
  #  Agent명: setting.agent.Agent명
  #  AGENT_URL: mSettings.AGENT_URL
  #  서비스_id: setting.service._id
  #  서비스명: setting.service.서비스명
  #  REQ_DATE: new Date('2016-08-15') #'201608151231000'
  #  CUR_IP: '10.0.0.24'
  #  DEL_FILE_LIST: [
  #    '/data/images/1.jpg'
  #    '/data/files/2.doc'
  #  ]
  #  UP_FSIZE: 3038920   #num type
  #  DEL_DATE: new Date('2016-08-20') #'201608201231000'
  #  KEEP_PERIOD: 10   #date
  #  STATUS: 'success'   # success or err_msg / delete error, sql error



  #setInterval ->
  #  path = setting.agent.소멸정보절대경로
  #  files = fs.readdirSync(path)
  #  if files.length > 0
  #    file = files[0]
  #
  #, 3000



  #for file in files

  #, 3000




  #lineReader = require('readline').createInterface
  #  input: require('fs').createReadStream('/Users/jwjin/data/DasReqInfo_201601021327567.das')
  #
  #lineReader.on 'line', (line) ->
  #  console.log(line)
