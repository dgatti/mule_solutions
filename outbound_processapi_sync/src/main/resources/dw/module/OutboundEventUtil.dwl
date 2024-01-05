%dw 2.0

fun getAttributes(obj) =
  if (obj is Object)
    obj.attributes
  else {}  


fun mapAttributes(obj) = 
  if (obj is Object) 
    obj mapObject ((value, key, index) -> ("em:" ++ key) @((getAttributes(value))): 
      if (value is Object)
        mapAttributes(value - "attributes")
      else value)  
  else {}
