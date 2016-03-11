class JSONAPIResource
  def initialize(document)
    @document = document
    @deserialized_objects = Hash.new{|h, k| h[k] = {}}
  end

  def deserialize
    primary_data = document['data']

    [deserialize_data(primary_data), meta]
  end

protected

  attr_reader :document, :deserialized_objects

private

  def meta
    document['meta']
  end

  def deserialize_data(data)
    object = deserialized_objects[key(data)]

    object.merge!(data['attributes'] || {})
    object.merge!(data.slice('id'))
    object.merge!(relationships(data['relationships']))

    object
  end

  def relationships(relationships)
    return {} if relationships.blank?

    relationships.map do |relation_name, relation_data|
      relations = relation_data['data']
      if relations.is_a?(Array)
        many_relationships(relation_name, relations)
      else
        single_relationship(relation_name, relations)
      end
    end.to_h
  end

  def many_relationships(relation_name, relations)
    type = :object
    relation_objects = relations.map do |relation_datum|
      object, type = lookup_or_deserialize_relation(relation_datum)

      object
    end

    [relation_attribute(relation_name, type).pluralize, relation_objects]
  end

  def single_relationship(relation_name, relation)
    relation_object, type = lookup_or_deserialize_relation(relation)
    [relation_attribute(relation_name, type), relation_object]
  end

  def lookup_or_deserialize_relation(relation)
    key = key(relation)
    object = deserialized_objects[key]

    if object.present?
      [object, :object]
    elsif resource_data[key].present?
      [deserialize_data(resource_data[key]), :object]
    else
      [relation['id'], :id]
    end
  end

  def relation_attribute(relation_name, type)
    case type
    when :id
      relation_name.singularize + '_id'
    else
      relation_name
    end
  end

  def resource_data
    return @resource_data if @resource_data

    data = ([document['data']] + document['included']).flatten

    @resource_data = data.map do |datum|
      [key(datum), datum]
    end.to_h
  end

  def key(datum)
    datum.values_at('type', 'id').map(&:to_s).join(':')
  end
end
