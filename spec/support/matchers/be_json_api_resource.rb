require 'json'

module JSONAPIMatcher
  JSONAPI_SCHEMA = JSON.parse(File.read(File.expand_path('../../jsonapi-v1.0.0-schema.json', __FILE__)))

  def be_json_api_resource(type)
    BeJSONAPIResource.new(type)
  end

  class BeJSONAPIResource
    include RSpec::Matchers

    def initialize(type, attributes = nil, relationships = nil, included = nil, meta = nil)
      @type = type
      @attributes = attributes&.deep_stringify_keys
      @relationships = relationships
      @included = included
      @meta = meta&.deep_stringify_keys
    end

    def including(*included)
      self.class.new(type, attributes, @relationships, included.flatten, meta)
    end

    def with_relationships(*relationships)
      self.class.new(type, attributes, relationships.flatten, included, meta)
    end

    def with_attributes(attributes)
      self.class.new(type, attributes, @relationships, included, meta)
    end

    def with_meta(meta)
      self.class.new(type, attributes, @relationships, included, meta)
    end

    def matches?(actual)
      json = actual.deep_stringify_keys

      validate_schema(json)
      validate_data(json['data'])
      validate_included(json)
      validate_meta(json)

      true
    end

  protected

    attr_reader :type, :attributes, :included, :meta

  private

    def relationships
      @relationships || directly_included
    end

    def directly_included
      @directly_included ||= direct_includes(included)
    end

    def validate_schema(json)
      expect(json).to validate_against_schema(JSONAPI_SCHEMA)
    end

    def validate_data(data)
      if plural?(type)
        validate_resources(data)
      else
        validate_resource(data)
      end
    end

    def validate_resources(resources)
      resources.each_with_index do |resource, index|
        validate_resource(resource, path: "#/data/#{index}")
      end
    end

    def validate_resource(resource, path: '#/data')
      return if resource.nil?

      expect(resource['type']).to eq(type.pluralize),
                                  "expected property '#{path}/type' to equal '#{type.pluralize}', was '#{resource['type']}'"

      validate_attributes(resource, path)
      validate_relationships(resource, path)
    end

    def validate_attributes(resource, path)
      return unless attributes

      expect(resource).to include('attributes'),
                          "expected property '#{path}' to have property 'attributes'"
      expect(resource['attributes']).to include(attributes),
                                        "expected property '#{path}/attributes' to include #{attributes.inspect}"
    end

    def validate_relationships(resource, path)
      return unless relationships

      expect(resource).to include('relationships'),
                          "expected property '#{path}' to have property 'relationships'"

      aggregate_failures do
        relationships.each do |relationship|
          expect(resource['relationships']).to include(relationship.to_s),
                                               "expected property '#{path}/relationships' to have property '#{relationship}'"
        end
      end
    end

    def validate_included(json)
      return unless included

      expect(json).to include('included'),
                      "expected property '#/' to have property 'included'"

      json_relationships = json_relationships(json)
      base_type = type_of(json)

      validate_relationship_included(json_relationships, base_type, included)
    end

    def validate_relationship_included(json_relationships, type, included)
      included.each do |inc|
        case inc
        when Hash
          validate_relationship_included(json_relationships, type, inc.keys)

          inc.each do |rel, nested_inc|
            validate_relationship_included(json_relationships, json_relationships.dig(type, rel.to_s), [nested_inc])
          end
        when Array
          validate_relationship_included(json_relationships, type, inc)
        else
          rel_type = json_relationships.dig(type, inc.to_s)

          expect(json_relationships.keys).to include(rel_type),
                                             "expected property '#/included' to include property '#{rel_type}'"
        end
      end
    end

    def json_relationships(json)
      json_relationships = Hash.new{|h, k| h[k] = {}}

      objects = json['included'] + [one_of(json['data'])]
      objects.each do |object|
        if object['relationships']
          object['relationships'].each do |rel, desc|
            json_relationships[object['type']][rel] = type_of(desc)
          end
        else
          json_relationships[object['type']] = nil
        end
      end

      json_relationships
    end

    def direct_includes(included)
      return nil unless included.is_a?(Array)

      included.map do |inc|
        if inc.respond_to?(:keys)
          inc.keys.map(&:to_s)
        else
          inc.to_s
        end
      end.flatten.uniq
    end

    def type_of(json)
      item = one_of(json['data'])

      item['type'] if item
    end

    def one_of(json)
      json.is_a?(Array) ? json.first : json
    end

    def validate_meta(json)
      return unless meta

      expect(json).to include('meta'),
                      "expected property '#/' to have property 'meta'"

      expect(json['meta']).to include(meta),
                              "expected property '#/meta' to include #{meta.inspect}"
    end

    def plural?(noun)
      noun.pluralize == noun
    end
  end
end
