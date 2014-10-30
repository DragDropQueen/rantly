/**
 * Created by savannah on 10/27/14.
 */
SITE.admin_rants = {
  init: function () {
  },
  index: function () {
    $('#all-button').css('background-color', '#91de76')
        .css('cursor', 'default')
        .attr('disabled', true);

    $('#start_date').datepicker({format: "yyyy-mm-dd", orientation: 'top auto'});

    $('#end_date').datepicker({format: "yyyy-mm-dd", orientation: 'top auto'});
  },
  spam: function () {
    $('#spam-button').css('background-color', '#91de76')
      .css('cursor', 'default')
      .attr('disabled', true);

    $('#start_date').datepicker({format: "yyyy-mm-dd", orientation: 'top auto'});

    $('#end_date').datepicker({format: "yyyy-mm-dd", orientation: 'top auto'});
  }
};