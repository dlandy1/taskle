<% if @item.valid? %>
 $('.js-items').append("<%= escape_javascript(render @item) %>");
 $('.new-item').html("<%= escape_javascript(render partial: 'items/form', locals: { todo: @todo, item: @new_item }) %>");
<% else %>
 $('.new-item').html("<%= escape_javascript(render partial: 'items/form', locals: { todo: @todo, item: @new_item  }) %>");
<% end %>