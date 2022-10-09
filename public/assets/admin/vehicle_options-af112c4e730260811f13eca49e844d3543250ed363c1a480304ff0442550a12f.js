$(document).on('turbolinks:load', function () {
  $('#table').bootstrapTable({
    url: 'vehicle_options.json',
    pagination: true,
    search: true,
    toolbar: '#toolbar',
    groupBy: true,
    groupByField: 'key',
  });
});
