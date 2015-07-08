Template.displayUserIcons.events
  'click .muteIcon': (event) ->
    toggleMic @

  'click .raisedHandIcon': (event) ->
    # the function to call 'userLowerHand'
    # the meeting id
    # the _id of the person whose land is to be lowered
    # the userId of the person who is lowering the hand
    BBB.lowerHand(getInSession("meetingId"), @userId, getInSession("userId"), getInSession("authToken"))

Template.displayUserIcons.helpers
  userLockedIconApplicable: (userId) ->
    # the lock settings affect the user (and requiire a lock icon) if
    # the user is set to be locked and there is a relevant lock in place
    locked = BBB.getUser(userId)?.user.locked
    settings = Meteor.Meetings.findOne()?.roomLockSettings
    lockInAction = settings.disablePrivChat or
                    settings.disableCam or
                    settings.disableMic or
                    settings.lockedLayout or
                    settings.disablePubChat
    return locked and lockInAction

# Opens a private chat tab when a username from the userlist is clicked 
Template.usernameEntry.events
  'click .usernameEntry': (event) ->
    userIdSelected = @.userId
    unless userIdSelected is null
      if userIdSelected is BBB.getCurrentUser()?.userId
        setInSession "inChatWith", "PUBLIC_CHAT"
      else
        setInSession "inChatWith", userIdSelected
    if isLandscape()
      $("#newMessageInput").focus()
    if isPortrait() or isPortraitMobile()
      toggleUsersList()
      $("#newMessageInput").focus()

  'click .gotUnreadMail': (event) ->
    _this = @
    setInSession 'chats', getInSession('chats').map((chat) ->
      chat.gotMail = false if chat.userId is _this.userId
      chat
    )

  'click .gotUnreadPublic': (event) ->
    setInSession 'chats', getInSession('chats').map((chat) ->
      chat.gotMail = false if chat.userId is 'PUBLIC_CHAT'
      chat
    )

Template.usernameEntry.helpers
  hasGotUnreadMailClass: (userId) ->
    chats = getInSession('chats') if getInSession('chats') isnt undefined
    flag = false
    chats.map((tab) ->
      if tab.userId is userId
        if tab.gotMail
          flag = true
      tab
    )
    if flag
      return "gotUnreadMail"
    else
      return ""
