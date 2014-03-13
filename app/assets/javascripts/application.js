// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery.tokeninput
//= require jquery_ujs
//= require bootstrap



$(function() {
  $("#question_tag_tokens").tokenInput("/tags.json", {
    crossDomain: false,
    prePopulate: $("#question_tag_tokens").data("pre"),
    theme: "facebook",
    preventDuplicates : true,
    tokenLimit :5
  });
});


function search_on_stackoverflow() {
  var query = $("#question_mark").val();
  if (query.length >= 3) {
    $.getJSON("https://api.stackexchange.com/2.2/search/advanced?site=stackoverflow&accepted=true&sort=relevance&q=" + query,
    function(questions){
      $("#question_list").empty();
      $.each(questions.items, function(i,item){
        if (i <= 10) {
          content = "<div class='panel panel-default'>\
            <div class='panel-heading'>\
              \
              <h2 class='panel-title'><div class='score'>  "+item.score+"</div>  <a href=" + item.link + ">" + item.title + "</a></h2>\
            </div>\
            <div class='panel-body' style='height:30px' >\
<ul class='tags'>"

          $.each(item.tags, function(j, tag){
            content += "<li><a href='http://stackoverflow.com/questions/tagged/" + tag + "'>" + tag + "</a></li>"
          })

          content += "\
                  </ul>\
              </div>\
            </div>\
            <br/>"

          $("#question_list").append(content);
        }
      });

     $("#question_list").append(questions.items.length + " questions");
     });
  }
}
