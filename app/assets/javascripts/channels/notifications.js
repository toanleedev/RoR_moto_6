$(document).ready(function () {
  App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
    connected: function () {
      // Called when the subscription is ready for use on the server
      console.log('connected');
    },

    disconnected: function () {
      // Called when the subscription has been terminated by the server
      console.log('disconected');
    },

    received: function (data) {
      // Called when there's incoming data on the websocket for this channel
      console.log('received', data);
    },
  });
});
