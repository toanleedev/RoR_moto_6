$(document).ready(function () {
  App.notifications = App.cable.subscriptions.create('MessagesChannel', {
    connected: function () {
      console.log('Messager connected');
    },

    disconnected: function () {
      console.log('Messager disconected');
    },

    received: function (data) {
      console.log(data);
    },
  });
});
