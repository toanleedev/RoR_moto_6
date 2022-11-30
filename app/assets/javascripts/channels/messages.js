$(document).ready(function () {
  App.messages = App.cable.subscriptions.create('MessagesChannel', {
    connected: function () {
      console.log('Messager connected');
    },

    disconnected: function () {
      console.log('Messager disconected');
    },

    received: function (data) {
      console.log(data);
      const messageList = $('.message-list');
      messageList.append(data.message);
    },
  });
});
