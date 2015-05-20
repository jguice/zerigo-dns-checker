# （╯°□°）╯︵ ┻━┻ 
#
# this is needed because the dependencies in zerigo*.rb are old and broken and sad

class Hash #:nodoc:
  # @return <String> This hash as a query string
  #
  # @example
  #   { :name => "Bob",
  #     :address => {
  #       :street => '111 Ruby Ave.',
  #       :city => 'Ruby Central',
  #       :phones => ['111-111-1111', '222-222-2222']
  #     }
  #   }.to_params
  #     #=> "name=Bob&address[city]=Ruby Central&address[phones][]=111-111-1111&address[phones][]=222-222-2222&address[street]=111 Ruby Ave."
  def to_params
    params = self.map { |k,v| normalize_param(k,v) }.join
    params.chop! # trailing &
    params
  end
  # @param key<Object> The key for the param.
  # @param value<Object> The value for the param.
  #
  # @return <String> This key value pair as a param
  #
  # @example normalize_param(:name, "Bob Jones") #=> "name=Bob%20Jones&"
  def normalize_param(key, value)
    param = ''
    stack = []
    if value.is_a?(Array)
      param << value.map { |element| normalize_param("#{key}[]", element) }.join
    elsif value.is_a?(Hash)
      stack << [key,value]
    else
      param << "#{key}=#{URI.encode(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}&"
    end
    stack.each do |parent, hash|
      hash.each do |key, value|
        if value.is_a?(Hash)
          stack << ["#{parent}[#{key}]", value]
        else
          param << normalize_param("#{parent}[#{key}]", value)
        end
      end
    end
    param
  end
end

class String #:nodoc:
  # @example "".blank?         #=>  true
  # @example "     ".blank?    #=>  true
  # @example " hey ho ".blank? #=>  false
  # 
  # @return <TrueClass, FalseClass>
  # 
  # Strips out whitespace then tests if the string is empty.
  def blank?
    strip.empty?
  end unless method_defined?(:blank?)
  def snake_case
    return self.downcase if self =~ /^[A-Z]+$/
    self.gsub(/([A-Z]+)(?=[A-Z][a-z]?)|\B[A-Z]/, '_\&') =~ /_*(.*)/
    return $+.downcase
  end unless method_defined?(:snake_case)
end # class String