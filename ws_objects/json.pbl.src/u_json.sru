$PBExportHeader$u_json.sru
forward
global type u_json from nonvisualobject
end type
end forward

global type u_json from nonvisualobject
end type
global u_json u_json

type variables
public jsonparser ijp_parser
public jsongenerator ijg_generator
public long il_handle

private boolean ibo_parsed, ibo_generated
private u_json iu_parent

private boolean ibo_type_defined
private jsonitemtype ijit_type
private string is_key
private long il_index
private u_json iu_nodes[]
private string is_value
private double ido_value
private boolean ibo_value


end variables

forward prototypes
public subroutine of_load_file (string as_path) throws exception
private function exception of_get_exception (string as_message)
public function blob of_get_value_blob () throws exception
public function boolean of_get_value_boolean () throws exception
public function date of_get_value_date () throws exception
public function datetime of_get_value_datetime () throws exception
public function double of_get_value_number () throws exception
public function string of_get_value_string () throws exception
public function time of_get_value_time () throws exception
public function jsonitemtype of_get_type () throws exception
public function long of_get_count () throws exception
public function u_json of_get_node (string as_key) throws exception
public function u_json of_get_node (long al_index) throws exception
public function string of_get_key () throws exception
public function boolean of_key_exists (string as_key) throws exception
public function u_json of_add_node () throws exception
public function u_json of_add_node (string as_key) throws exception
private subroutine of_check_type (jsonitemtype ajit_type, string as_message) throws exception
public subroutine of_parse () throws exception
private subroutine of_init_jsonparser () throws exception
public subroutine of_changed ()
public function string of_get_json_string () throws exception
public subroutine of_save_to_file (string as_filename) throws exception
public function u_json of_get_parent () throws exception
public subroutine of_replace_node (string as_key, u_json au_node) throws exception
public function u_json of_add_node (ref u_json au_node) throws exception
public function u_json of_add_node (string as_key, ref u_json au_node) throws exception
public function u_json of_change_key (string as_key) throws exception
public function u_json of_delete_node (long al_index) throws exception
public function long of_get_index () throws exception
public function u_json of_delete_node (string as_key) throws exception
private subroutine of_generate () throws exception
private subroutine of_generate (ref jsongenerator ajg_generator, long al_handle, u_json au_json) throws exception
public subroutine of_load_string (string as_json) throws exception
public function u_json of_create_copy ()
public function u_json of_replace_node (long al_index, u_json au_node) throws exception
public function u_json of_reset ()
public function u_json of_set_type (jsonitemtype ajit_type) throws exception
public function u_json of_set_value (boolean abo_value) throws exception
public function u_json of_set_value (double ado_value) throws exception
public function u_json of_set_value (string as_value) throws exception
public function u_json of_set_value_null () throws exception
public function string of_get_version ()
end prototypes

public subroutine of_load_file (string as_path) throws exception;/**
description:	load a file and parse it
parameters:		string as_path:	path where the json file will be found
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

string ls_json
integer li_file

li_file = fileopen(as_path, textmode!, read!, shared!)
if li_file > 0 then
	if filereadex(li_file, ls_json) < 0 then
		throw of_get_exception('Error reading the file')
	end if
else
	throw of_get_exception('Error opening file to read')
end if

of_load_string(ls_json)
end subroutine

private function exception of_get_exception (string as_message);/** private
description:	helper function to get an exception object with message
parameters:		string as_message:	the string which should be set into the exception
return:			exception
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

exception lu_exception
lu_exception = create exception
lu_exception.setmessage(as_message)
return lu_exception
end function

public function blob of_get_value_blob () throws exception;/**
description:	returns json content of the current position as blob
					only works for type string (jsonstringitem!)
return:			blob content
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

if of_get_type() <> jsonstringitem! then
	throw of_get_exception('you can only get a blob from a string node')
end if

return blob(is_value)
end function

public function boolean of_get_value_boolean () throws exception;/**
description:	returns json content of the current position as boolean
					only works for type boolean (jsonbooleanitem!)
return:			boolean content
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

boolean lbo_null

choose case of_get_type()
	case jsonnullitem!
		setnull(lbo_null)
		return lbo_null
	case jsonbooleanitem!
		return ibo_value
	case else
		throw of_get_exception('you can only get a boolean from a boolean node')
end choose
end function

public function date of_get_value_date () throws exception;/**
description:	returns json content of the current position as date
					only works for type string (jsonstringitem!)
					variant with long timestamp is not yet implemented
return:			date content
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

return date(of_get_value_string())
end function

public function datetime of_get_value_datetime () throws exception;/**
description:	returns json content of the current position as datetime
					only works for type string (jsonstringitem!)
					variant with long timestamp is not yet implemented
return:			datetime content
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

return datetime(of_get_value_string())
end function

public function double of_get_value_number () throws exception;/**
description:	returns json content of the current position as double
					only works for type number (jsonnumberitem!)
return:			double content
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

double ldo_null

choose case of_get_type()
	case jsonnullitem!
		setnull(ldo_null)
		return ldo_null
	case jsonnumberitem!
		return ido_value
	case else
		throw of_get_exception('you can only get a number from a number node')
end choose
end function

public function string of_get_value_string () throws exception;/**
description:	returns json content of the current position as string
					only works for type string (jsonstringitem!)
return:			string content
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

string ls_null

choose case of_get_type()
	case jsonnullitem!
		setnull(ls_null)
		return ls_null
	case jsonstringitem!
		return is_value
	case else
		throw of_get_exception('you can only get a string from a string node')
end choose
end function

public function time of_get_value_time () throws exception;/**
description:	returns json content of the current position as time
					only works for type string (jsonstringitem!)
					variant with long timestamp is not yet implemented
return:			time content
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

return time(of_get_value_string())
end function

public function jsonitemtype of_get_type () throws exception;/**
description:	returns the type of the current node as jsonitemtype
					to get the type of a child use of_get_node(...).of_get_type()
return:			jsonitemtype type of current node (see PB documentation of jsonparser/jsongenerator for more information)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

if not ibo_type_defined then
	throw of_get_exception('The type of this node is not yet defined')
end if

return ijit_type
end function

public function long of_get_count () throws exception;/**
description:	returns the number of child nodes
					works for arrays and objects
return:			long number of child nodes
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

return upperbound(iu_nodes)
end function

public function u_json of_get_node (string as_key) throws exception;/**
description:	returns the json node of a child specified by key
parameters:		string as_key:	key of the child that should be returned
return:			u_json child node with specified key
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

long ll_i

if of_get_type() <> jsonobjectitem! then
	throw of_get_exception('you can only get a node by key in an object node')
end if

for ll_i = 1 to upperbound(iu_nodes)
	if iu_nodes[ll_i].of_get_key() = as_key then
		return iu_nodes[ll_i]
	end if
next

throw of_get_exception('node ' + as_key + ' doesn~'t exist')
end function

public function u_json of_get_node (long al_index) throws exception;/**
description:	returns the json node of a child specified by index
parameters:		long al_index:	index of the child that should be returned
return:			u_json child node with specified index
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

if al_index < 1 or upperbound(iu_nodes) < al_index then
	throw of_get_exception('index ' + string(al_index) + ' doesn~'t exist')
else
	return iu_nodes[al_index]
end if
	


end function

public function string of_get_key () throws exception;if len(is_key) > 0 then
	return is_key
else
	throw of_get_exception('no key availlable - this is root or an element in an array node')
end if
end function

public function boolean of_key_exists (string as_key) throws exception;/**
description:	checks whether a key in a json object exists
return:			boolean - true if key exists, false if not
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

long ll_i

if of_get_type() <> jsonobjectitem! then
	// throw of_get_exception('you can only get a node by key in an object node')
	return false
end if

for ll_i = 1 to upperbound(iu_nodes)
	if iu_nodes[ll_i].of_get_key() = as_key then
		return true
	end if
next

return false
end function

public function u_json of_add_node () throws exception;/**
description:	creates a new node to the current position
					only works, if the current position is a node of type array
return:			u_json which represents the new created node
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

u_json lu_json
long ll_index

of_check_type(jsonarrayitem!, 'a node without key can only be added to a node of type array')

lu_json = create u_json
lu_json.iu_parent = this
ll_index = upperbound(iu_nodes) + 1
lu_json.il_index = ll_index
iu_nodes[ll_index] = lu_json

of_changed()

return lu_json
end function

public function u_json of_add_node (string as_key) throws exception;/**
description:	creates a new node to the current position
					only works, if the current position is a node of type object
parameters:		string as_key: the key at which the new node should be created
return:			u_json which represents the new created node
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

u_json lu_json
long ll_index

of_check_type(jsonobjectitem!, 'a node with key can only be added to a node of type object')

lu_json = create u_json
lu_json.iu_parent = this
lu_json.is_key = as_key
ll_index = upperbound(iu_nodes) + 1
lu_json.il_index = ll_index
iu_nodes[ll_index] = lu_json

of_changed()

return lu_json
end function

private subroutine of_check_type (jsonitemtype ajit_type, string as_message) throws exception;/** private
description:	helper function to automaticliy set the jsonitemtype
					sets the type if not yet set, throws an exception if an other type is already set
parameters:		jsonitemtype ajit_type:	type that should be used
					string as_message:		message for the exception, if the type cannot be set
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

if ibo_type_defined and ijit_type <> ajit_type then
	throw of_get_exception(as_message)
elseif not ibo_type_defined then
	ijit_type = ajit_type
	ibo_type_defined = true
end if
end subroutine

public subroutine of_parse () throws exception;/** private
description:	helper function that parses the json from jsonparser into u_json
					creates all child nodes and calls of_parse for them as well to create recursion
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

long ll_i, ll_handle
string ls_key
jsonitemtype ljit_type
u_json lu_node

for ll_i = 1 to ijp_parser.getchildcount(il_handle)
	ll_handle = ijp_parser.getchilditem(il_handle, ll_i)
	ljit_type = ijp_parser.getitemtype(ll_handle)
	if ijit_type = jsonobjectitem! then
		ls_key = ijp_parser.getchildkey(il_handle, ll_i)
		lu_node = of_add_node(ls_key)
	else
		lu_node = of_add_node()
	end if
	
	choose case ljit_type
		case jsonobjectitem!, jsonarrayitem!
			lu_node.ijp_parser = ijp_parser
			lu_node.il_handle = ijp_parser.getchilditem(il_handle, ll_i)
			lu_node.of_set_type(ljit_type)
			lu_node.of_parse()
		case jsonstringitem!
			lu_node.of_set_value(ijp_parser.getitemstring(ll_handle))
		case jsonnumberitem!
			lu_node.of_set_value(ijp_parser.getitemnumber(ll_handle))
		case jsonbooleanitem!
			lu_node.of_set_value(ijp_parser.getitemboolean(ll_handle))
		case jsonnullitem!
			lu_node.of_set_value_null()
	end choose
next
end subroutine

private subroutine of_init_jsonparser () throws exception;/** private
description:	helper function to be executed after a json is parsed with jsonparser
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

of_changed()

il_handle = ijp_parser.getrootitem()
ijit_type = ijp_parser.getitemtype(il_handle)
ibo_type_defined = true
of_parse()

ibo_parsed = true
end subroutine

public subroutine of_changed ();/** private
description:	marks a change that has been made, so jsonparser or jsongenerator objects will be regenerated if needed
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

ibo_parsed = false
ibo_generated = false

// also set all parents to changed recursively
if isvalid(iu_parent) then iu_parent.of_changed()
end subroutine

public function string of_get_json_string () throws exception;/**
description:	generate the json (if not yet done) and get the json as string
					works with every node and jsonitemtype
return:			string of json content
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

if not ibo_generated then of_generate()

return ijg_generator.getjsonstring()
end function

public subroutine of_save_to_file (string as_filename) throws exception;/**
description:	generate the json (if not yet done) and write it to a file
					works with every node and jsonitemtype
parameters:		string as_filename: path to the file which should be created
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

string ls_json
integer li_file

ls_json = of_get_json_string()

li_file = fileopen(as_filename, linemode!, write!, lockwrite!, replace!)
if li_file > 0 then
	if filewriteex(li_file, ls_json) < 0 then
		throw of_get_exception('Error writing the file')
	end if
	fileclose(li_file)
else
	throw of_get_exception('Error opening the file to write')
end if

end subroutine

public function u_json of_get_parent () throws exception;/**
description:	returns the parent node
					doesn't work with the root
return:			u_json parent node
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

if isvalid(iu_parent) then
	return iu_parent
else
	throw of_get_exception('node is root and doesn~'t have a parent')
end if
end function

public subroutine of_replace_node (string as_key, u_json au_node) throws exception;/**
description:	replace an existing child node with another existing u_json object
					if au_node is a subset of another u_json, the surrounding construct will not be usable any more.
					use of_create_copy to prevent that from happening
parameters:		string as_key:		key of the child node you want to replace
					u_json au_node:	json object to replace the specified node with
return:			u_json that has been replaced (as au_node)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

of_replace_node(of_get_node(as_key).of_get_index(), au_node)
end subroutine

public function u_json of_add_node (ref u_json au_node) throws exception;/**
description:	adds an existing node to the current position
					only works, if the current position is a node of type array
					if au_node is a subset of another u_json, the surrounding construct will not be usable any more.
					use of_create_copy to prevent that from happening
parameters:		u_json au_node:	the json object, which should be added to the current node
return:			u_json which represents the added node (same as parameter)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

long ll_index

of_check_type(jsonarrayitem!, 'a node without key can only be added to a node of type array')

// setup the passed object
au_node.iu_parent = this

// find the next index and set it on the new node
ll_index = upperbound(iu_nodes) + 1
au_node.il_index = ll_index

// add the node to the current position
iu_nodes[ll_index] = au_node

of_changed()

return au_node
end function

public function u_json of_add_node (string as_key, ref u_json au_node) throws exception;/**
description:	adds an existing node to the current position
					only works, if the current position is a node of type object
					if au_node is a subset of another u_json, the surrounding construct will not be usable any more.
					use of_create_copy to prevent that from happening
parameters:		string as_key: the key at which the node should be added
					u_json au_node: the json object which should be added to the current node
return:			u_json which represents the added node (same as parameter)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

long ll_index

of_check_type(jsonobjectitem!, 'a node with key can only be added to a node of type object')

au_node.iu_parent = this
au_node.is_key = as_key
ll_index = upperbound(iu_nodes) + 1
au_node.il_index = ll_index
iu_nodes[ll_index] = au_node

of_changed()

return au_node
end function

public function u_json of_change_key (string as_key) throws exception;/**
description:	changes the key of the current position
					if you want to change the key of a child, use of_get_node(...).of_change_key()
parameters:		string as_key: the new key you want to set
return:			the current u_json object
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

if len(is_key) = 0 then
	throw of_get_exception('The key can only be changed if the root is an object. This is either root or child of an array.')
end if

is_key = as_key

of_changed()

return this
end function

public function u_json of_delete_node (long al_index) throws exception;/**
description:	deletes a child node at a specified index
					the index numbers of the remaining child nodes will be regenerated
					(the order remains, but gaps will be closed)
parameters:		long al_index:	the index of the node to be deleted
return:			u_json which represents the current position (self)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

long ll_i, ll_index = 1
u_json lu_nodes[]

if al_index > upperbound(iu_nodes) or al_index < 1 then
	throw of_get_exception('node ' + string(al_index) + ' doesn~'t exist')
end if

// regenerate index numbers
for ll_i = 1 to upperbound(iu_nodes)
	if ll_i = al_index then continue
	lu_nodes[ll_index] = iu_nodes[ll_i]
	iu_nodes[ll_index].il_index = ll_index
	ll_index ++
next

iu_nodes = lu_nodes

return this
end function

public function long of_get_index () throws exception;/**
description:	returns the index of the current position
					works with nodes in objects and arrays, but not with root
return:			long index of current position
created:			2019-10-18
author:			georg.brodbeck@informaticon.com
*/

if il_index > 0 then
	return il_index
else
	throw of_get_exception('cant get the index of root')
end if
end function

public function u_json of_delete_node (string as_key) throws exception;/**
description:	deletes a child node at a specified key
					the index numbers of the remaining child nodes will be regenerated
					(the order remains, but gaps will be closed)
parameters:		string as_key:	the key of the node to be deleted
return:			u_json which represents the current position (self)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

of_delete_node(of_get_node(as_key).of_get_index())

return this
end function

private subroutine of_generate () throws exception;/** private
description:	creates the jsongenerator object
					is called automaticly when needed
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

long ll_handle
boolean lbo_generate

ijg_generator = create jsongenerator

choose case of_get_type()
	case jsonarrayitem!
		ll_handle = ijg_generator.createjsonarray()
		lbo_generate = true
	case jsonobjectitem!
		ll_handle = ijg_generator.createjsonobject()
		lbo_generate = true
	case jsonstringitem!
		ll_handle = ijg_generator.createjsonobject()
		ijg_generator.additemstring(ll_handle, is_value)
	case jsonnumberitem!
		ll_handle = ijg_generator.createjsonobject()
		ijg_generator.additemnumber(ll_handle, ido_value)
	case jsonbooleanitem!
		ll_handle = ijg_generator.createjsonobject()
		ijg_generator.additemboolean(ll_handle, ibo_value)
	case jsonnullitem!
		ll_handle = ijg_generator.createjsonobject()
		ijg_generator.additemnull(ll_handle)
end choose

if lbo_generate then
	of_generate(ijg_generator, ll_handle, this)
end if

ibo_generated = true
end subroutine

private subroutine of_generate (ref jsongenerator ajg_generator, long al_handle, u_json au_json) throws exception;/** private
description:	recursive helper funktion to create the jsongenerator object
					is called by of_generate (without parameters)
parameters:		jsongenerator ajg_generator:	generator object into which the objects should be inserted
					long al_handle:					handle to the jsongenerator object for the current node
					u_json au_json:					u_json node which should be inserted into ajg_generator
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

long ll_i, ll_handle
boolean lbo_array
u_json lu_node

if au_json.of_get_type() = jsonarrayitem! then lbo_array = true

// loop through every child and insert them
// make recursive call for objects and arrays
for ll_i = 1 to au_json.of_get_count()
	lu_node = au_json.of_get_node(ll_i)
	choose case lu_node.of_get_type()
		case jsonobjectitem!
			if lbo_array then
				ll_handle = ajg_generator.additemobject(al_handle)
			else
				ll_handle = ajg_generator.additemobject(al_handle, lu_node.of_get_key())
			end if
			of_generate(ajg_generator, ll_handle, lu_node)
		case jsonarrayitem!
			if lbo_array then
				ll_handle = ajg_generator.additemarray(al_handle)
			else
				ll_handle = ajg_generator.additemarray(al_handle, lu_node.of_get_key())
			end if
			of_generate(ajg_generator, ll_handle, lu_node)
		case jsonstringitem!
			if lbo_array then
				ll_handle = ajg_generator.additemstring(al_handle, lu_node.of_get_value_string())
			else
				ll_handle = ajg_generator.additemstring(al_handle, lu_node.of_get_key(), lu_node.of_get_value_string())
			end if
		case jsonnumberitem!
			if lbo_array then
				ll_handle = ajg_generator.additemnumber(al_handle, lu_node.of_get_value_number())
			else
				ll_handle = ajg_generator.additemnumber(al_handle, lu_node.of_get_key(), lu_node.of_get_value_number())
			end if
		case jsonbooleanitem!
			if lbo_array then
				ll_handle = ajg_generator.additemboolean(al_handle, lu_node.of_get_value_boolean())
			else
				ll_handle = ajg_generator.additemboolean(al_handle, lu_node.of_get_key(), lu_node.of_get_value_boolean())
			end if
		case jsonnullitem!
			if lbo_array then
				ll_handle = ajg_generator.additemnull(al_handle)
			else
				ll_handle = ajg_generator.additemnull(al_handle, lu_node.of_get_key())
			end if
	end choose
next
end subroutine

public subroutine of_load_string (string as_json) throws exception;/**
description:	parse a json string
parameters:		string as_json:	json string to parse
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

string ls_ret
exception lu_exception

ijp_parser = create jsonparser

ls_ret = ijp_parser.loadstring(as_json)
if len(ls_ret) > 0 then
	lu_exception = create exception
	lu_exception.setmessage(ls_ret)
	throw lu_exception
end if

of_init_jsonparser()
end subroutine

public function u_json of_create_copy ();/**
description:	creates a copy of the current position (without parent information)
					children are being copied as well
return:			u_json copy of the current node
created:			2019-10-18
author:			georg.brodbeck@informaticon.com
*/

u_json lu_json
long ll_i

lu_json = create u_json

lu_json.ijp_parser = ijp_parser
lu_json.il_handle = il_handle

lu_json.ibo_parsed = ibo_parsed
lu_json.ibo_generated = false
lu_json.ibo_type_defined = ibo_type_defined
lu_json.ijit_type = ijit_type
lu_json.is_value = is_value
lu_json.ido_value = ido_value
lu_json.ibo_value = ibo_value

for ll_i = 1 to upperbound(iu_nodes)
	lu_json.iu_nodes[ll_i] = iu_nodes[ll_i].of_create_copy()
	lu_json.iu_nodes[ll_i].is_key = iu_nodes[ll_i].is_key
	lu_json.iu_nodes[ll_i].il_index = iu_nodes[ll_i].il_index
	lu_json.iu_nodes[ll_i].iu_parent = lu_json
next

return lu_json
end function

public function u_json of_replace_node (long al_index, u_json au_node) throws exception;/**
description:	replace an existing child node with another existing u_json object
					if au_node is a subset of another u_json, the surrounding construct will not be usable any more.
					use of_create_copy to prevent that from happening
parameters:		long al_index:		index of the child node you want to replace
					u_json au_node:	json object to replace the specified node with
return:			u_json that has been replaced (as au_node)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

long ll_i

if al_index > upperbound(iu_nodes) or al_index < 1 then
	throw of_get_exception('node ' + string(al_index) + ' doesn~'t exist')
end if

au_node.iu_parent = this
au_node.il_index = al_index
iu_nodes[al_index] = au_node

of_changed()

return au_node
end function

public function u_json of_reset ();/**
description:	reset a node to the state it has when it was created
					use this function if you want to change the type (jsonitemtype!) of a node
return:			u_json which represents the current position (self)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

u_json lu_nodes[]

ibo_type_defined = false
iu_nodes = lu_nodes
is_value = ''
ido_value = 0
ibo_value = false

of_changed()

return this
end function

public function u_json of_set_type (jsonitemtype ajit_type) throws exception;/**
description:	set the type (jsonitemtype!) of the current node
					usually, this isn't necessary, as the type is set automaticly
					however, use this function, if you, for some reason, want to set the type manually
parameter:		jsonitemtype ajit_type:	type you want to set
return:			u_json which represents the current position (self)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

if not ibo_type_defined then
	ijit_type = ajit_type
	ibo_type_defined = true
else
	throw of_get_exception('type is already defined')
end if

return this
end function

public function u_json of_set_value (boolean abo_value) throws exception;/**
description:	set a value to the current json node
					if the current node already has a value of type boolean, the value will be overwritten
					if the current node has a different type, an exception will be trown. use of_reset to change the tye
parameters:		boolean abo_value:	the value to set. if the value is null, the type jsonnullitem! will be set
return:			u_json which represents the current position (self)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

jsonitemtype ljit_type

ljit_type = jsonbooleanitem!

if isnull(abo_value) then ljit_type = jsonnullitem!

of_check_type(ljit_type, 'can~'t set a boolean value to a non-boolean node')

if not isnull(abo_value) then ibo_value = abo_value

of_changed()

return this
end function

public function u_json of_set_value (double ado_value) throws exception;/**
description:	set a value to the current json node
					if the current node already has a value of type number, the value will be overwritten
					if the current node has a different type, an exception will be trown. use of_reset to change the tye
parameters:		double ado_value:	the value to set. if the value is null, the type jsonnullitem! will be set
return:			u_json which represents the current position (self)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

jsonitemtype ljit_type

ljit_type = jsonnumberitem!

if isnull(ado_value) then ljit_type = jsonnullitem!

of_check_type(ljit_type, 'can~'t set a numeric value to a non-numeric node')

if not isnull(ado_value) then ido_value = ado_value

of_changed()

return this
end function

public function u_json of_set_value (string as_value) throws exception;/**
description:	set a value to the current json node
					if the current node already has a value of type string, the value will be overwritten
					if the current node has a different type, an exception will be trown. use of_reset to change the tye
parameters:		string as_value:	the value to set. if the value is null, the type jsonnullitem! will be set
return:			u_json which represents the current position (self)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

jsonitemtype ljit_type

ljit_type = jsonstringitem!

if isnull(as_value) then ljit_type = jsonnullitem!

of_check_type(ljit_type, 'can~'t set a string value to a non-string node')

is_value = as_value

of_changed()

return this
end function

public function u_json of_set_value_null () throws exception;/**
description:	set the current node to null
					a node with a value null type can be detected using of_get_type()
return:			u_json which represents the current position (self)
created:			2019-10-14
author:			georg.brodbeck@informaticon.com
*/

of_check_type(jsonnullitem!, 'type is already set, can~'t change it anymore')

of_changed()

return this
end function

public function string of_get_version ();/**
description:	returns the version of the u_json class
return:			string version (in semantic versioning style)
created:			2019-10-18
author:			georg.brodbeck@informaticon.com
*/

return '1.1.0'
end function

on u_json.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_json.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

