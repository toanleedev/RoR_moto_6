$(document).on('turbolinks:load', function () {
  const selectRank = $('#priority_rank');
  const selectDuration = $('#priority_duration');
  const inputAmount = $('#priority_amount');
  const btnActionSilver = $('.btn-action-silver');
  const btnActionGold = $('.btn-action-gold');
  const btnActionDiamon = $('.btn-action-diamon');

  selectRank.on('change', function () {
    calcAmount();
  });

  selectDuration.on('change', function () {
    calcAmount();
  });

  btnActionSilver.on('click', () => {
    selectRank.val('silver').change;
    calcAmount();
  });
  btnActionGold.on('click', () => {
    selectRank.val('gold').change;
    calcAmount();
  });
  btnActionDiamon.on('click', () => {
    selectRank.val('diamon').change;
    calcAmount();
  });

  function calcAmount() {
    let rank = selectRank.val();
    let duration = parseInt(selectDuration.val());
    let price = 0;
    switch (rank) {
      case 'silver': {
        price = duration * 50000;
        break;
      }
      case 'gold': {
        price = duration * 80000;
        break;
      }
      case 'diamon': {
        price = duration * 100000;
        break;
      }
    }
    inputAmount.val(price);
  }

  calcAmount();
});
