$(document).on('turbolinks:load', function () {
  var defaultStartDate = moment().add(1, 'days').startOf('day').add(7, 'hours');
  var defaultEndDate = moment().add(1, 'days').startOf('day').add(19, 'hours');

  $('#start_date').datetimepicker({
    locale: 'vi',
    minDate: moment().startOf('day').add(7, 'hours'),
    defaultDate: defaultStartDate,
    sideBySide: true,
  });
  $('#end_date').datetimepicker({
    locale: 'vi',
    sideBySide: true,
    minDate: moment().startOf('day').add(7, 'hours'),
    defaultDate: defaultEndDate,
  });

  // Watch time change
  $('#start_date').on('change.datetimepicker', function (e) {
    $('#end_date').datetimepicker('minDate', e.date);
  });
  $('#end_date').on('change.datetimepicker', function (e) {
    $('#start_date').datetimepicker('maxDate', e.date);
  });
});
