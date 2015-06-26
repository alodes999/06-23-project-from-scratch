require 'active_support'
require 'active_support/inflector'

module DatabaseInstanceMethods
  # Returns the stored value in the field passed from our DB.  The id number the method looks
  # for is referenced in the Object that the method is called on.
  # 
  # Accepts 1 argument, the field in our table we want to retrieve the information from
  # 
  # Returns a String or Integer, or whatever value is stored in the field we are requesting
  def get(field)
    result = CONNECTION.execute("SELECT * FROM #{tablename} WHERE id = #{@id}}").first
    
    result[field]
  end
  # Saves the current values in our instance variables into the row in the table referenced
  # by our Object's id
  # 
  # Takes no arguments, using the instance's attributes
  # 
  # Returns the Object itself, along with syncing the row and Object
  def save
    variables = self.instance_variables
    attr_hash = {}
    
    variables.each do |var|
      attr_hash["#{var.slice(1..-1)}"] = self.send("#{var.slice(1..-1)}")
    end
    
    single_variables = []
    
    attr_hash.each do |k, v|
      if v.is_a?(String)
        single_variables << "#{k} = '#{v}'"
      else
        single_variables << "#{k} = #{v}"
      end
    end
    
    vars_to_sql = single_variables.join(", ")
    
    CONNECTION.execute("UPDATE #{tablename} SET #{vars_to_sql} WHERE id = #{self.id}")
    
    return self
  end
  # Grabs the name of the class, and turns it into a tableized version to use for SQL
  # 
  # Accepts no arguments, grabbing the name of the class itself
  # 
  # Returns a String of the class in SQL table form
  def tablename
    self.class.to_s.tableize
  end
end