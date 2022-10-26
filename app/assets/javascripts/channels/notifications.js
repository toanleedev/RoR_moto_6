App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
  connected: function () {
    // Called when the subscription is ready for use on the server
    alert('connected');
  },

  disconnected: function () {
    // Called when the subscription has been terminated by the server
    alert('disconected');
  },

  received: function (data) {
    // Called when there's incoming data on the websocket for this channel
    $('#notification-list').prepend(data.layout);
    alert('received');
  },
});
