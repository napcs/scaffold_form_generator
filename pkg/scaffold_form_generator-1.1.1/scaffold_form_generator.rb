

class ScaffoldingSandbox
  include ActionView::Helpers::ActiveRecordHelper

  attr_accessor :form_action, :singular_name, :suffix, :model_instance

  def sandbox_binding
    binding
  end
  
  def default_input_block
    Proc.new { |record, column| "<p><label for=\"#{record}_#{column.name}\">#{column.human_name}</label><br/>\n#{input(record, column.name)}</p>\n" }
  end
  
end


module ActionView::Helpers::ActiveRecordHelper
  
  def all_input_tags(record, record_name, options)
    input_block = options[:input_block] || default_input_block
    skip_columns = ["created_at", "lock_version", "created_on", "updated_at", "updated_on"]
    @results = record.class.content_columns.collect do |column|
     unless skip_columns.detect{|c| c == column.name}  || column.name.last(3) == "id"
       input_block.call(record_name, column) 
     end
    end
    
    @results.join("")

    
  end
  
  
  
  def all_associations(record)
    
     @results =""
     puts record.class.reflect_on_all_associations.inspect
     record.class.reflect_on_all_associations.each do |a|
      puts a.inspect
      if a.macro == :belongs_to
        @results += "<p>#{a.klass}<br/><%=f.select #{a.klass}.find(:all).collect {|i| [ p.inspect, p.id ] }, { :include_blank => true }) %>"
      end

    end
    
    @results
  end
  
  
  
  
end


class ActionView::Helpers::InstanceTag
  
  
      def to_tag(options = {})
        case column_type
          when :string
            field_type = @method_name.include?("password") ? "password" : "text"
            to_input_field_tag(field_type, options)
          when :text
            to_text_area_tag(options)
          when :integer, :float, :decimal
            to_input_field_tag("text", options)
          when :date
            to_date_select_tag(options)
          when :datetime, :timestamp
            to_datetime_select_tag(options)
          when :time
            to_time_select_tag(options)
          when :boolean
            to_boolean_checkbox_tag(options)
        end
      end
  
  
  def to_input_field_tag(field_type, options={})
    field_meth = "#{field_type}_field"
    "<%= f.#{field_meth} '#{@method_name}' #{options.empty? ? '' : ', '+options.inspect} %>"
  end

  def to_boolean_checkbox_tag(options = {})
    "<%= f.check_box '#{@method_name}' #{options.empty? ? '' : ', '+ options.inspect} %>"
  end
  
  def to_text_area_tag(options = {})
    "<%= f.text_area '#{@method_name}' #{options.empty? ? '' : ', '+ options.inspect} %>"
  end

  def to_date_select_tag(options = {})
    "<%= f.date_select '#{@method_name}' #{options.empty? ? '' : ', '+ options.inspect} %>"
  end

  def to_datetime_select_tag(options = {})
       "<%= f.datetime_select '#{@method_name}' #{options.empty? ? '' : ', '+ options.inspect} %>"
  end
  
  def to_time_select_tag(options = {})
    "<%= f.time_select '#{@method_name}' #{options.empty? ? '' : ', '+ options.inspect} %>"
  end
end

class ScaffoldFormGenerator < Rails::Generator::NamedBase
  attr_reader   :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_singular_name,
                :controller_plural_name
  alias_method  :controller_file_name,  :controller_singular_name
  alias_method  :controller_table_name, :controller_plural_name

  def initialize(runtime_args, runtime_options = {})
    super

    # Take controller name from the next argument.  Default to the pluralized model name.
    @controller_name = args.shift
    @controller_name ||= ActiveRecord::Base.pluralize_table_names ? @name.pluralize : @name

    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_singular_name, @controller_plural_name = inflect_names(base_name)

    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end
  end

  def manifest
    record do |m|

      # Controller, helper, views, and test directories.

      m.directory File.join('app/views', controller_class_path, controller_file_name)



      # Scaffolded forms.
      m.complex_template "form.rhtml",
        File.join('app/views',
                  controller_class_path,
                  controller_file_name,
                  "_form.html.erb"),
        :insert => 'form_scaffolding.rhtml',
        :sandbox => lambda { create_sandbox },
        :begin_mark => 'form',
        :end_mark => 'eoform',
        :mark_id => singular_name


      # Scaffolded views.
      scaffold_views.each do |action|
        m.template "view_#{action}.rhtml",
                   File.join('app/views',
                             controller_class_path,
                             controller_file_name,
                             "#{action}.html.erb"),
                   :assigns => { :action => action }
      end











    end
  end

  protected
    # Override with your own usage banner.
    def banner
      "Usage: #{$0} scaffold ModelName [ControllerName]"
    end

    def scaffold_views
      %w(new edit)
    end


    
    def model_name 
      class_name.demodulize
    end

    def suffix
      "_#{singular_name}" if options[:suffix]
    end

    def create_sandbox
      sandbox = ScaffoldingSandbox.new
      sandbox.singular_name = singular_name
      begin
        sandbox.model_instance = model_instance
        sandbox.instance_variable_set("@#{singular_name}", sandbox.model_instance)
      rescue ActiveRecord::StatementInvalid => e
        logger.error "Before updating scaffolding from new DB schema, try creating a table for your model (#{class_name})"
        raise SystemExit
      end
      sandbox.suffix = suffix
      sandbox
    end
    
    def model_instance
      base = class_nesting.split('::').inject(Object) do |base, nested|
        break base.const_get(nested) if base.const_defined?(nested)
        base.const_set(nested, Module.new)
      end
      unless base.const_defined?(@class_name_without_nesting)
        base.const_set(@class_name_without_nesting, Class.new(ActiveRecord::Base))
      end
      class_name.constantize.new
    end
end
