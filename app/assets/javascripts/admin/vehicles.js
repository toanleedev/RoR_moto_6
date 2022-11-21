$(document).on('turbolinks:load', function () {
  $('#table').bootstrapTable({
    url: 'vehicles.json',
    pagination: true,
    search: true,
  });
  //
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
