class EventSerializer
    include FastJsonapi::ObjectSerializer

    attributes :name, :id
  end