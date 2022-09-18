$(document).on('turbolinks:load', function () {
  var currentDate = moment().toDate();
  var initStartDate = $('#start_date').data('init');
  var initEndDate = $('#end_date').data('init');
  var defaultStartDate = initStartDate
    ? moment(initStartDate)
    : moment().add(1, 'days').startOf('day').add(7, 'hours');
  var defaultEndDate = initEndDate
    ? moment(initEndDate)
    : moment().add(1, 'days').startOf('day').add(19, 'hours');
  // alert(defaultStartDate);
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
  renderRentalTime();
  renderTotal();
  // Set time
  $('#start_date').on('change.datetimepicker', function (e) {
    $('#end_date').datetimepicker('minDate', e.date);
    renderRentalTime();
    renderTotal();
  });
  $('#end_date').on('change.datetimepicker', function (e) {
    $('#start_date').datetimepicker('maxDate', e.date);
    renderRentalTime();
    renderTotal();
  });

  $('#is_home_delivery').change(function () {
    if (this.checked) {
      $('.delivery_address_js').show();
      // $('.is_home_delivery_price_js').show();
      renderTotal();
    } else {
      $('.delivery_address_js').hide();
      // $('.is_home_delivery_price_js').hide();
      renderTotal();
    }
  });

  function renderRentalTime() {
    var startDate = $('#start_date').data('datetimepicker').date();
    var endDate = $('#end_date').data('datetimepicker').date();
    var dateDiff = endDate.diff(startDate, 'days', false);

    if (dateDiff === 0) dateDiff = 1;

    $('.rental_time_js').html(`x${dateDiff} ngày`);
    $('input[name="rental_time"]').val(dateDiff);
    renderTotal();
  }

  function renderTotal() {
    let rentalTime = $('input[name="rental_time"]').val();
    let vehiclePrice = $('input[name="unit_price"]').val();
    let total = vehiclePrice * rentalTime;

    $('.total_js').html(total);
    $('input[name="total"]').val(total);
  }
});
