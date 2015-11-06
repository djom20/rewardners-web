$(function() {

  // DatePicker
  validateDatePickerGreater("#promo_start_at", "#promo_end_at");

  // Categories and SubCategories
  var rootCategoriesSelector = "#promo_category_id",
      subCategoriesSelector1 = "#promo_subcategory1_id",
      subCategoriesLabel = "label[for='promo_subcategory1_id']",
      subCategoriesSelector2 = "#promo_subcategory2_id",
      subcategoriesUrlSelector = "#subcategories_url";

  if($(rootCategoriesSelector).val() == "" || $(rootCategoriesSelector).val() == null){
    $(subCategoriesSelector1).empty();
    $(subCategoriesSelector1).hide();
    $(subCategoriesLabel).hide();
  }

  if($(subCategoriesSelector1).val() == "" || $(subCategoriesSelector1).val() == null){
    $(subCategoriesSelector2).empty();
    $(subCategoriesSelector2).hide();
  }

  $(rootCategoriesSelector).on('change', function (){

    $(subCategoriesSelector1).empty();
    $(subCategoriesSelector1).hide();
    $(subCategoriesLabel).hide();

    $(subCategoriesSelector2).empty();
    $(subCategoriesSelector2).hide();

    if(!parseInt($(this).val())){
      $(subCategoriesSelector2).empty();
      $(subCategoriesSelector2).hide();
    }else{
      var url = $(subcategoriesUrlSelector).val();
      loadSubcategories(rootCategoriesSelector, subCategoriesSelector1, 2, url);
    }
  });

  $(subCategoriesSelector1).on('change', function () {

    $(subCategoriesSelector2).empty();
    $(subCategoriesSelector2).hide();

    if(parseInt($(this).val())){
      var url = $(subcategoriesUrlSelector).val();
      loadSubcategories(subCategoriesSelector1, subCategoriesSelector2, 3, url);
    }
  });

  var loadSubcategories = function(selectorChange, selectorUpdate, level, url) {
    $.ajax({
      url: url,
      method: "GET",
      data: {
        level: level,
        selector: selectorUpdate,
        category_id: $(selectorChange).val()
      },
      dataType: "script"
    });
  };

});
