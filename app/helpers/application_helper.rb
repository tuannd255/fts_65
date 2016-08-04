module ApplicationHelper

  def full_title page_title = ""
    base_title = t :title
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def link_to_add_fields name, f, type
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render type.to_s + "_fields", f: builder
    end
    link_to name, "#", class: "add_fields add",
      data: {id: id, fields: fields.gsub("\n", "")}
  end

  def link_to_add_field name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for association, new_object,
      child_index: id do |answer_form|
      render association.to_s.singularize + "_fields", f: answer_form
    end
    link_to name, "#", class: "add_fields",
      data: {id: id, fields: fields.gsub("\n", "")}
  end

  def link_to_function name, *args, &block
    html_options = args.extract_options!.symbolize_keys

    function = block_given? ? update_page(&block) : args[0] || ""
    onclick = "#{"#{html_options[:onclick]};
      "if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || "#"

    content_tag :a, name, html_options.merge(href: href,
      onclick: onclick)
  end

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def add_fields_answer f, association
    render_fields f, association
    @tmpl = @tmpl.gsub /(?<!\n)\n(?!\n)/, " "
    return "<script> var #{association.to_s}_field = '#{@tmpl.to_s}' </script>"
      .html_safe
  end

  def time_form time
    Time.at(time).utc.strftime t "time.formats.time_format"
  end

  def background answer, result
    content_tag :span, answer.answer, class: answer.is_correct? ?
      "list-group-item-success th-display" : "th-display"
  end

  private
  def render_fields f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    @tmpl = f.fields_for association, new_object,
      child_index: "new_#{association}" do |b|
      render "#{association.to_s.singularize}_fields", f: b
    end
  end
end
