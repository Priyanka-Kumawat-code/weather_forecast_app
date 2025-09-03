class CacheService
  def self.fetch_or_store(zip, &block)
    key = "weather:#{zip}"
    cached = Rails.cache.read(key)
    return { data: cached, cached: true } if cached

    data = yield
    Rails.cache.write(key, data, expires_in: 30.minutes)
    { data: data, cached: false }
  end
end
