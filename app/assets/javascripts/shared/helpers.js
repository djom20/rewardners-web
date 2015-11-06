$.rails.allowAction = function(link) {
  if (!link.attr('data-confirm')) {
    return true;
  }
  $.rails.showConfirmDialog(link);
  return false;
};

$.rails.confirmed = function(link) {
  link.removeAttr('data-confirm');
  return link.trigger('click.rails');
};

$.rails.showConfirmDialog = function(link) {
  var html, message;
  message = link.attr('data-confirm');
  html = "<div class=\"modal\" id=\"confirmationDialog\">\n <div class=\"modal-dialog\">\n <div class=\"modal-header\">\n    <a class=\"close\" data-dismiss=\"modal\">×</a>\n    <h3>" + message + "</h3>\n  </div>\n  <div class=\"modal-body\">\n    <p>Are you sure you want to delete?</p>\n  </div>\n  <div class=\"modal-footer\">\n    <a data-dismiss=\"modal\" class=\"btn\">Cancel</a>\n    <a data-dismiss=\"modal\" class=\"btn btn-primary confirm\">OK</a>\n  </div>\n </div>\n</div>";
  $(html).modal();
  return $('#confirmationDialog .confirm').on('click', function() {
    return $.rails.confirmed(link);
  });
};

var initDatePicker = function(selector) {
  $(selector).datepicker({
    format: 'dd-mm-yyyy',
    startDate: '-3d',
    autoclose: true
  });
};

var validateDatePickerGreater = function(start_date, finish_date ) {
  $(start_date).datepicker({
    format: 'dd-mm-yyyy',
    startDate: new Date(),
    autoclose: true,
    todayHighlight: true
  }).on('changeDate', function (selected) {
    var startDate = new Date(selected.date.valueOf());
    $(finish_date).datepicker('setStartDate', startDate);
    var e = $.Event("keyup");
    e.keyCode = 13;
    $(this).trigger(e);
  }).on('clearDate', function (selected) {
    $(finish_date).datepicker('setStartDate', null);
  });

  $(finish_date).datepicker({
    format: 'dd-mm-yyyy',
    autoclose: true,
    todayHighlight: true
  }).on('changeDate', function (selected) {
    var endDate = new Date(selected.date.valueOf());
    $(start_date).datepicker('setEndDate', endDate);
    var e = $.Event("keyup");
    e.keyCode = 13;
    $(this).trigger(e);
  }).on('clearDate', function (selected) {
    $(start_date).datepicker('setEndDate', null);
  });
};

var initializeTelInput = function (selector){
  $(selector).intlTelInput({
    preferredCountries: ['US', 'CO'],
    autoHideDialCode: true,
    defaultCountry: "",
    nationalMode: true
  });
};


