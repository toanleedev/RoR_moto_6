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
      const main = $('.main');
      main.append(data.toast);
      var toastElList = [].slice.call(document.querySelectorAll('.toast'));

      // Add toast notification
      toastElList.map(function (toastEl) {
        new bootstrap.Toast(toastEl).show();
        toastEl.addEventListener('hidden.bs.toast', function (event) {
          toastEl.remove();
        });
      });

      // Add notification in list
      const notificationList = $('.notify-list');
      notificationList.prepend(data.notification);

      // Add notification counter
      const notificationButton = $('.notification-button-js');
      if (notificationButton.find('span.badge').length !== 0) {
        const counterEl = notificationButton.children('span.badge');
        counterEl.text(parseInt(counterEl.text()) + 1);
      } else {
        notificationButton.append(data.counter);
      }
    },
  });
});
