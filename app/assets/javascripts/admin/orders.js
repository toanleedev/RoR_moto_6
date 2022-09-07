$(document).on('turbolinks:load', function () {
  $('#table').bootstrapTable({
    url: 'orders.json',
    pagination: true,
    search: true,
    toolbar: '#toolbar',
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
        <p>${data.phone}</p>
        <p>Số lần đăt: </p>
        <p>Số xe sở hữu: </p>
        <p></p>

        <a class="btn btn-primary" href="/admin/users/${data.id}">Xem chi tiết</a>
      </div>
    `
    
    canvasInfo.html(htmls)
  }
});
