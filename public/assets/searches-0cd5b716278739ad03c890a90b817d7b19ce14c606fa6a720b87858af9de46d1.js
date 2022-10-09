$(document).on('turbolinks:load', function () {
  const formatDate = 'DD/MM/YYYY HH:mm';
  var initStartDate = $('#start_date').data('init');
  var initEndDate = $('#end_date').data('init');

  var defaultStartDate = initStartDate
    ? moment(initStartDate, formatDate)
    : moment().add(1, 'days').startOf('day').add(7, 'hours');
  var defaultEndDate = initEndDate
    ? moment(initEndDate, formatDate)
    : moment().add(1, 'days').startOf('day').add(19, 'hours');

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

  renderRentalTime();
  renderTotal();

  $('#is_home_delivery').change(function () {
    var inputDeliveryAddress = $('.delivery_address_js');
    if (this.checked) {
      inputDeliveryAddress.show();
      // $('.is_home_delivery_price_js').show();
      renderTotal();
    } else {
      inputDeliveryAddress.hide();
      // $('.is_home_delivery_price_js').hide();
      renderTotal();
    }
  });

  function renderRentalTime() {
    var textRentalTime = $('.rental_time_js');
    var inputRentalTime = $('input[name="rental_time"]');
    if (!textRentalTime.length || !inputRentalTime.length) return;
    var startDate = $('#start_date').data('datetimepicker').date();
    var endDate = $('#end_date').data('datetimepicker').date();
    var dateDiff = endDate.diff(startDate, 'days', false);

    if (dateDiff === 0) dateDiff = 1;

    textRentalTime.html(`x${dateDiff} ngày`);
    inputRentalTime.val(dateDiff);
    renderTotal();
    return;
  }

  function renderTotal() {
    let rentalTime = $('input[name="rental_time"]').val();
    let vehiclePrice = $('input[name="unit_price"]').val();
    var textTotal = $('.total_js');
    var inputTotal = $('input[name="total"]');
    if (!textTotal.length || !inputTotal.length) return;

    let total = vehiclePrice * rentalTime;

    textTotal.html(total);
    inputTotal.val(total);
    return;
  }

  $('.js-province-select').select2({
    dropdownAutoWidth: true,
    width: '100%',
  });
});
