$(document).ready(function () {
  document.addEventListener('turbolinks:load', function () {
    var toastElList = [].slice.call(document.querySelectorAll('.toast'));
    var toastList = toastElList.map(function (toastEl) {
      return new bootstrap.Toast(toastEl).show(); // No need for options; use the default options
    });
  });
});
