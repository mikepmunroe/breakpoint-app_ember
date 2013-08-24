BreakpointApp.User = DS.Model.extend
  firstName:   DS.attr('string')
  lastName:    DS.attr('string')
  phoneNumber: DS.attr('string')
  email:       DS.attr('string')
  fullName: (->
    "#{@get('firstName')} #{@get('lastName')}"
  ).property('firstName', 'lastName')

