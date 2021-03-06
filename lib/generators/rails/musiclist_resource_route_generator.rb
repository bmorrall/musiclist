# frozen_string_literal: true

module Rails
  class MusiclistResourceRouteGenerator < Rails::Generators::NamedBase # :nodoc:
    # Properly nests namespaces passed into a generator
    #
    #   $ bin/rails generate resource admin/users/products
    #
    # should give you
    #
    #   namespace :admin do
    #     namespace :users do
    #       resources :products, concerns: :paginatable
    #     end
    #   end
    def add_resource_route
      return if options[:actions].present?

      depth = 0
      lines = []

      # Create 'namespace' ladder
      # namespace :foo do
      #   namespace :bar do
      regular_class_path.each do |ns|
        lines << indent("namespace :#{ns} do\n", depth * 2)
        depth += 1
      end

      # inserts the primary resource with pagination routes
      lines << indent("resources :#{file_name.pluralize}, concerns: :paginatable\n", depth * 2)

      # Create `end` ladder
      #   end
      # end
      until depth.zero?
        depth -= 1
        lines << indent("end\n", depth * 2)
      end

      route lines.join
    end

    def add_paginatable_concern
      route <<~PAGINATABLE
        concern :paginatable do
          get "page/:page", action: :index, on: :collection, as: ""
        end
      PAGINATABLE
    end
  end
  # rubocop:enable
end
