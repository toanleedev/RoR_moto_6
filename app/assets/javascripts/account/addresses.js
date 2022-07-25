$(document).on('turbolinks:load', function () {
  // addresses/1/edit
  var url = window.location.pathname.split('/');
  if (url[url.length - 1] === 'edit') {
    var addressId = url[url.length - 2];
    var userAddressInfo = fetchAddressUser(addressId);
    fetchProvince(userAddressInfo.province);
    fetchDistrict(userAddressInfo.district);
    fetchWard(userAddressInfo.ward);
  } else if (url[url.length - 1] === 'new') {
    fetchProvince();
    fetchDistrict();
    fetchWard();
  }

  function fetchAddressUser(addressId) {
    var theResponse = null;
    $.ajax({
      url: `/account/addresses/${addressId}/edit`,
      method: 'GET',
      dataType: 'json',
      async: false,
      error: function (xhr, ajaxOptions, thrownError) {
        console.log(thrownError);
      },
      success: function (response) {
        theResponse = response;
      },
    });

    return theResponse;
  }

  function fetchProvince(userProvince) {
    $.ajax({
      url: 'https://provinces.open-api.vn/api/',
      success: function (response) {
        response.forEach((province) => {
          $('#address_province').append(
            `<option value="${province.name.replace(
              /Tỉnh |Thành phố /g,
              ''
            )}" data-code="${province.code}">${province.name.replace(
              /Tỉnh |Thành phố /g,
              ''
            )}</option>`
          );
        });
        if (userProvince) {
          $('#address_province').val(userProvince).change();
        }
      },
    });
  }

  function fetchDistrict(userDistrict) {
    $(document).on('change', '#address_province', function () {
      var province_code = $(this).find(':selected').data('code');
      var districtSelect = $('#address_district');
      districtSelect.empty();
      districtSelect.removeAttr('disabled');
      $.ajax({
        url: 'https://provinces.open-api.vn/api/p/' + province_code,
        data: { depth: 2 },
        success: function (response) {
          response.districts.forEach((district) => {
            districtSelect.append(
              `<option value="${district.name}" data-code="${district.code}">${district.name}</option>`
            );
          });
          if (userDistrict) {
            districtSelect.val(userDistrict).change();
          }
        },
      });
    });
  }

  function fetchWard(userWard) {
    $(document).on('change', '#address_district', function () {
      var district_code = $(this).find(':selected').data('code');
      var wardSelector = $('#address_ward');
      wardSelector.empty();
      wardSelector.removeAttr('disabled');
      $.ajax({
        url: 'https://provinces.open-api.vn/api/d/' + district_code,
        data: { depth: 2 },
        success: function (response) {
          response.wards.forEach((ward) => {
            wardSelector.append(
              `<option value="${ward.name}" data-code="${ward.code}">${ward.name}</option>`
            );
          });

          if (userWard) {
            wardSelector.val(userWard).change();
          }
        },
      });
    });
  }
});
