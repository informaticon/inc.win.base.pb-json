$PBExportHeader$u_data.sru
forward
global type u_data from nonvisualobject
end type
end forward

global type u_data from nonvisualobject
end type
global u_data u_data

type variables
long il_article_number[] = {345, 21346, 3264, 687, 123, 2345, 4356}
string is_article_description[] = {'Keyboard', 'Mouse', 'Notebook', 'Printer', 'Screen', 'Docking Station', 'Software'}
decimal ide_article_price[] = {18.75, 12.3, 1989, 209, 299, 176, 2846.35}

long il_address_number[] = {2581, 2368, 2687, 7562, 3698, 5416, 6987}
string is_address_name[] = {'Charles Higgins', 'Peter Mayer', 'Steve Harper', 'Joana Betterfield', 'Barbara Kingstone', 'Hazel Sandberg', 'Ben Aftershow'}
string is_address_address[] = {'99 Betterstreed', 'Route 66', '499 Diagon Alley', '23 Minor Big Field', '1234 6th Street', '33 Walnut Avenue', 'Nirvana'}
string is_address_zip[] = {'12345', '85265', '1596', '85645', '36954', '23845', '45934', '32222'}
string is_address_city[] = {'Bestcity', 'Houston', 'Philadelphia', 'Arperville', 'Alphaville', 'Aftershow', 'Bermuda Triangle'}
string is_address_phone[] = {'3521 687 68461 5658', '', '6542335 354 8564 8', '354 6584 6354', '', '', '666'}

end variables

forward prototypes
public subroutine of_fill_address (datawindow adw)
public subroutine of_fill_article (datawindow adw)
public subroutine of_fill_address (datawindowchild adw)
public subroutine of_fill_article (datawindowchild adw)
public subroutine of_fill_order (datawindow adw)
public subroutine of_fill_order_detail (datawindow adw)
end prototypes

public subroutine of_fill_address (datawindow adw);long ll_i

for ll_i = 1 to upperbound(il_address_number)
	adw.insertrow(ll_i)
	adw.setitem(ll_i, 'number', il_address_number[ll_i])
	adw.setitem(ll_i, 'name', is_address_name[ll_i])
	adw.setitem(ll_i, 'address', is_address_address[ll_i])
	adw.setitem(ll_i, 'city', is_address_city[ll_i])
	adw.setitem(ll_i, 'zip', is_address_zip[ll_i])
	adw.setitem(ll_i, 'phone', is_address_phone[ll_i])
next
end subroutine

public subroutine of_fill_article (datawindow adw);long ll_i

for ll_i = 1 to upperbound(il_article_number)
	adw.insertrow(ll_i)
	adw.setitem(ll_i, 'number', il_article_number[ll_i])
	adw.setitem(ll_i, 'description', is_article_description[ll_i])
	adw.setitem(ll_i, 'price', ide_article_price[ll_i])
next
end subroutine

public subroutine of_fill_address (datawindowchild adw);long ll_i

for ll_i = 1 to upperbound(il_address_number)
	adw.insertrow(ll_i)
	adw.setitem(ll_i, 'number', il_address_number[ll_i])
	adw.setitem(ll_i, 'name', is_address_name[ll_i])
	adw.setitem(ll_i, 'address', is_address_address[ll_i])
	adw.setitem(ll_i, 'city', is_address_city[ll_i])
	adw.setitem(ll_i, 'zip', is_address_zip[ll_i])
	adw.setitem(ll_i, 'phone', is_address_phone[ll_i])
next
end subroutine

public subroutine of_fill_article (datawindowchild adw);long ll_i

for ll_i = 1 to upperbound(il_article_number)
	adw.insertrow(ll_i)
	adw.setitem(ll_i, 'number', il_article_number[ll_i])
	adw.setitem(ll_i, 'description', is_article_description[ll_i])
	adw.setitem(ll_i, 'price', ide_article_price[ll_i])
next
end subroutine

public subroutine of_fill_order (datawindow adw);long ll_i

for ll_i = 1 to 50
	adw.insertrow(0)
	
	adw.setitem(ll_i, 'order_date', relativedate(today(), - rand(60)))
	adw.setitem(ll_i, 'address', il_address_number[rand(upperbound(il_address_number))])
next
end subroutine

public subroutine of_fill_order_detail (datawindow adw);long ll_i, ll_max, ll_art, ll_amount

ll_max = rand(30)

for ll_i = 1 to ll_max
	adw.insertrow(0)
	
	ll_art = rand(upperbound(il_article_number))
	adw.setitem(ll_i, 'article', il_article_number[ll_art])
	adw.setitem(ll_i, 'price', ide_article_price[ll_art])
	ll_amount = rand(5)
	adw.setitem(ll_i, 'amount', ll_amount)
	adw.setitem(ll_i, 'sum', ll_amount * ide_article_price[ll_art])
next
end subroutine

on u_data.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_data.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

