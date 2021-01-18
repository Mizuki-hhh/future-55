$(function(){
  function appendOption(category){
    var html = `<option value='${category.id}'>${category.name}</option>`;
    return html;
  }
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
                        <div class='listing-select-wrapper__box'>
                          <select class='listing-select-wrapper__box--select' id='child_category' name='content[category_id]'>
                            <option value='---' category_id='---'>---</option>
                            ${insertHTML}
                          </select>
                        </div>
                      </div>`;
    $('.listing-content-detail__category').append(childSelectHtml);
  }
  $('#parent_category').on('change', function() {
    $("#children_wrapper").remove();
    var parentId = document.getElementById("parent_category").value;
    if (parentId != '---'){
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_id: parentId },
        dataType: 'json'
      })
      .done(function(children){
        $("#children_wrapper").remove();
        var insertHTML = "";
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました1');
      })
    }else{
      $("#children_wrapper").remove();
    }
  })
});