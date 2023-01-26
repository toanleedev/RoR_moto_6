$(document).on('turbolinks:load', function () {
  $('#table').bootstrapTable({
    url: 'payment_history.json',
    pagination: true,
  });
});
