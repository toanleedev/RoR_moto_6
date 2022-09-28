$(document).on('turbolinks:load', function () {
  $('#table').bootstrapTable({
    url: 'users.json',
    pagination: true,
    search: true,
    toolbar: '#toolbar',
  });
});
