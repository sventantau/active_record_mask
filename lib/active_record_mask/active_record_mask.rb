module ActiveRecordMask
  extend ActiveSupport::Concern

  module ClassMethods
    def configure_active_record_mask
      yield self if block_given?
      @allowed_attributes ||= [:id]
      @allowed_associations ||= []
    end

    def revealed_defaults(value = nil)
      @revealed_defaults = value if value
      @revealed_defaults ||= {}
    end

    def allow_attributes(value = nil)
      @allowed_attributes = value if value
    end

    def allow_associations(value = nil)
      @allowed_associations = value if value
    end

    def show_real_data_by_default(value = nil)
      @show_real_data_by_default = value if value
      @show_real_data_by_default ||= false
    end

    attr_reader :allowed_attributes, :allowed_associations
  end

  included do
    configure_active_record_mask {}
    after_initialize :initialize_protector
    prepend InstanceMethods
  end

  def mask_down!
    @show_real_data = true
  end

  def mask_up!
    @show_real_data = false
  end

  private

  def initialize_protector
    @show_real_data = self.class.show_real_data_by_default

    self.class.reflect_on_all_associations.each do |reflection|
      association = reflection.name

      define_singleton_method(association) do
        if @show_real_data || self.class.allowed_associations.include?(association.to_sym)
          super()
        else
          reflection.klass.none
        end
      end

      if reflection.macro == :has_many || reflection.macro == :has_and_belongs_to_many
        define_singleton_method("#{association.to_s.singularize}_ids") do
          if @show_real_data || self.class.allowed_associations.include?(association.to_sym)
            super()
          else
            []
          end
        end
      end
    end
  end

  module InstanceMethods
    def _read_attribute(attr_name, &block)
      return super(attr_name, &block) if @show_real_data

      if self.class.allowed_attributes.include?(attr_name.to_sym) || self.class.allowed_attributes.empty?
        return super(attr_name, &block)
      end

      empty_value_for_attribute(attr_name)
    end

    def empty_value_for_attribute(attr_name)
      column = self.class.columns_hash[attr_name.to_s]
      return nil unless column

      if self.class.revealed_defaults.key?(attr_name.to_sym)
        return self.class.revealed_defaults[attr_name.to_sym]
      end

      case column.type
      when :string, :text
        if (column.try(:array) rescue false)
          []
        else
          ""
        end
      when :integer, :float, :decimal
        0
      when :datetime, :timestamp, :time, :date
        nil
      when :boolean
        false
      when :json, :jsonb, :hstore
        {}
      when :array
        []
      else
        nil
      end
    end
  end
end
