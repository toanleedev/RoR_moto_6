$(document).on('turbolinks:load', function () {
  var $table = $('#table');
  var $remove = $('#remove');

  $table.bootstrapTable({
    url: 'vehicles.json',
    pagination: true,
    search: true,
  });

  $(document).on('click', '.user_canvas_js', async function () {
    var userId = $(this).data('id');
    var loading = $('.loading-js');
    var canvasInfo = $('.canvas-info-js');

    loading.show();
    canvasInfo.hide();

    const response = await fetch(`users/${userId}.json`);
    const user = await response.json();
    loading.hide();
    renderCanvasInfo(user);
    canvasInfo.show();
  });

  function getIdSelections() {
    return $.map($table.bootstrapTable('getSelections'), function (row) {
      return row.id;
    });
  }

  $table.on(
    'check.bs.table uncheck.bs.table ' +
      'check-all.bs.table uncheck-all.bs.table',
    function () {
      $remove.prop('disabled', !$table.bootstrapTable('getSelections').length);
    }
  );

  $remove.click(function () {
    var ids = getIdSelections();
    $.ajax({
      url: `vehicles/bulk_accepted`,
      method: 'PATCH',
      data: { ids: ids },
      success: function () {
        $table.bootstrapTable('refresh');
      },
    });
    $remove.prop('disabled', true);
  });

  function renderCanvasInfo(data) {
    var canvasInfo = $('.canvas-info-js');

    const htmls = `
      <div>
        <p>${data.full_name}</p>
        <p>${data.email}</p>

        <a class="btn btn-primary" href="/admin/users/${data.id}">Xem chi tiết</a>
      </div>
    `;

    canvasInfo.html(htmls);
  }
});
