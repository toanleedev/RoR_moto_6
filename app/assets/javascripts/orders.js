$(document).on('turbolinks:load', function () {
  var currentDate = moment().toDate();
  var initStartDate = $('#start_date').data('init');
  var initEndDate = $('#end_date').data('init');
  var cbIsHomeDelivery = $('input[name="order[is_home_delivery]"]');

  var defaultStartDate = initStartDate
    ? moment(initStartDate)
    : moment().add(1, 'days').startOf('day').add(7, 'hours');
  var defaultEndDate = initEndDate
    ? moment(initEndDate)
    : moment().add(1, 'days').startOf('day').add(19, 'hours');

  $('#start_date').datetimepicker({
    locale: 'vi',
    defaultDate: defaultStartDate,
    sideBySide: true,
  });
  $('#end_date').datetimepicker({
    locale: 'vi',
    sideBySide: true,
    defaultDate: defaultEndDate,
  });

  // Handle is_home_delivery checked
  if (!cbIsHomeDelivery.is(':checked')) {
    $('.delivery_address_js').hide();
  }

  cbIsHomeDelivery.change(() => {
    if (cbIsHomeDelivery.is(':checked')) {
      $('.delivery_address_js').show();
    } else {
      $('.delivery_address_js').hide();
    }
  });

  // Handle when date change
  $('#start_date').on('change.datetimepicker', function (e) {
    $('#end_date').datetimepicker('minDate', e.date);
    handleRentalTime();
  });
  $('#end_date').on('change.datetimepicker', function (e) {
    $('#start_date').datetimepicker('maxDate', e.date);
    handleRentalTime();
  });

  // Handle change rental times
  function handleRentalTime() {
    var startDate = $('#start_date').data('datetimepicker').date();
    var endDate = $('#end_date').data('datetimepicker').date();
    var dateDiff = endDate.diff(startDate, 'days', false);

    $('input[name="order[count_rental_days]"]').val(dateDiff);
    calculateTotal();
  }

  function calculateTotal() {
    let rentalTime = $('input[name="order[count_rental_days]"]').val();
    let vehiclePrice = $('input[name="order[vehicle_price]"]').val();
    let total = vehiclePrice * rentalTime;

    $('input[name="order[amount]"]').val(total);
  }
});
