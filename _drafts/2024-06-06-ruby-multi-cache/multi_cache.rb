require "rails/all"

# Litecache => Memcached
# https://github.com/oldmoe/litestack/blob/master/lib/litestack/litecache.rb

module Rails
  def self.root
    Pathname.new(__dir__)
  end
end

module WithMultiCache

  def file_memcached(...)
    MultiCache.file_memcached(...)
  end

end

class MultiCache < ActiveSupport::Cache::Store
  # Inspiration:
  #   https://oldmoe.blog/2024/05/13/comparing-sqlite-based-rails-cache-stores/

  attr_reader :caches
  cattr_accessor :fi_mc_cache_store

  def initialize(caches, options = nil)
    super(options)

    @caches = caches
  end

  # File => Memcached
  def self.file_memcached(options = nil)
    return self.fi_mc_cache_store if self.fi_mc_cache_store

    options ||= {}
    options[:file_cache_path] ||= Rails.root.join("tmp/file_cache_store")

    self.fi_mc_cache_store = new([
      ActiveSupport::Cache.lookup_store(:file_store, options[:file_cache_path]),
      ActiveSupport::Cache.lookup_store(:mem_cache_store, options),
    ])
  end

  # READS
  # Performed until not nil
  def fetch(name, options = nil, &block)
    caches.each do |cache|
      val = cache.fetch(name, options, &block)
      return val unless val.nil?
    end
  end

  def read(name, options = nil)
    caches.each do |cache|
      val = cache.read(name, options, &block)
      return val unless val.nil?
    end
  end

  def exist?(name, options = nil)
    caches.find { |cache| cache.exist?(name, options) }
  end

  # WRITES
  # Performed on all caches
  def write(name, value, options = nil)
    caches.each { |cache| cache.write(name, value, options) }
  end

  def delete(name, options = nil)
    caches.each { |cache| cache.delete(name, options) }.present?
  end

end

p MultiCache.file_memcached.fetch("flum"){ "bof" }
p MultiCache.file_memcached.fetch("flum"){ "bof2" }
p MultiCache.file_memcached.fetch("flum"){ "bof3" }
