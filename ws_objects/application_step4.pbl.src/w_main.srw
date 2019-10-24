$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type dw_menu from datawindow within w_main
end type
end forward

global type w_main from window
integer width = 4754
integer height = 1980
boolean titlebar = true
string title = "Awesome Application"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
string icon = "AppIcon!"
boolean center = true
dw_menu dw_menu
end type
global w_main w_main

type variables
long il_menu_hovered_row
window iw_window_stack[]
string is_window_stack[]

long il_border_left = 1100
long il_border_top = 0
end variables

forward prototypes
public function window of_open_window (string as_window_name)
public function window of_activate_window (long al_key)
public subroutine of_close_window (string as_window_name)
public function boolean of_window_is_open (string as_window_name)
end prototypes

public function window of_open_window (string as_window_name);long ll_i, ll_key

for ll_i = 1 to upperbound(is_window_stack)
	if is_window_stack[ll_i] = as_window_name then
		return of_activate_window(ll_i)
	end if
next

ll_key = upperbound(is_window_stack) + 1
is_window_stack[ll_key] = as_window_name
open(iw_window_stack[ll_key], as_window_name)

return of_activate_window(ll_key)

end function

public function window of_activate_window (long al_key);long ll_i
string ls_temp[]
window lw_temp[]

if al_key < upperbound(is_window_stack) then
	for ll_i = 1 to upperbound(is_window_stack)
		if ll_i <> al_key then
			ls_temp[upperbound(ls_temp) + 1] = is_window_stack[ll_i]
			lw_temp[upperbound(lw_temp) + 1] = iw_window_stack[ll_i]
		end if		
	next
	ls_temp[upperbound(ls_temp) + 1] = is_window_stack[al_key]
	lw_temp[upperbound(lw_temp) + 1] = iw_window_stack[al_key]
	is_window_stack = ls_temp
	iw_window_stack = lw_temp
	
	al_key = upperbound(ls_temp)
end if

iw_window_stack[al_key].x = il_border_left
iw_window_stack[al_key].y = il_border_top
iw_window_stack[al_key].width = workspacewidth() - il_border_left
iw_window_stack[al_key].height = workspaceheight() - il_border_top

iw_window_stack[al_key].show()

return iw_window_stack[al_key]
end function

public subroutine of_close_window (string as_window_name);long ll_i
string ls_temp[], ls_list
window lw_temp[]

for ll_i = 1 to upperbound(is_window_stack)
	if is_window_stack[ll_i] <> as_window_name then
		ls_temp[upperbound(ls_temp) + 1] = is_window_stack[ll_i]
		lw_temp[upperbound(lw_temp) + 1] = iw_window_stack[ll_i]
	end if
next

is_window_stack = ls_temp
iw_window_stack = lw_temp

// if detail window: open list now
if right(as_window_name, len(as_window_name) - lastpos(as_window_name, '_')) = 'detail' then
	ls_list = left(as_window_name, lastpos(as_window_name, '_')) + 'list'
	of_open_window(ls_list)
end if
end subroutine

public function boolean of_window_is_open (string as_window_name);long ll_i

for ll_i = 1 to upperbound(is_window_stack)
	if is_window_stack[ll_i] = as_window_name then
		return true
	end if
next

return false
end function

on w_main.create
this.dw_menu=create dw_menu
this.Control[]={this.dw_menu}
end on

on w_main.destroy
destroy(this.dw_menu)
end on

event open;long ll_i
string ls_menu_display[], ls_menu_window[]

gw_main = this

ls_menu_display = {'Address', 'Article', 'Order', 'Reporting'}
ls_menu_window = {'w_address_list', 'w_article_list', 'w_order', 'w_reporting'}

for ll_i = 1 to upperbound(ls_menu_display)
	dw_menu.insertrow(0)
	dw_menu.setitem(ll_i, 'display_name', ls_menu_display[ll_i])
	dw_menu.setitem(ll_i, 'window_name', ls_menu_window[ll_i])
next
end event

event resize;dw_menu.height = workspaceheight()
end event

type dw_menu from datawindow within w_main
event ue_mousemove pbm_dwnmousemove
integer width = 1102
integer height = 1880
integer taborder = 10
string title = "none"
string dataobject = "d_menu"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;if il_menu_hovered_row > 0 then
	dw_menu.setitem(il_menu_hovered_row, 'hover', 0)
	il_menu_hovered_row = 0
end if

if row > 0 then
	dw_menu.setitem(row, 'hover', 1)
	il_menu_hovered_row = row
end if
end event

event clicked;string ls_windowname, ls_detail
window lw_window

if row > 0 then	
	ls_windowname = getitemstring(row, 'window_name')
	
	if right(ls_windowname, len(ls_windowname) - lastpos(ls_windowname, '_')) = 'list' then
		ls_detail = left(ls_windowname, lastpos(ls_windowname, '_')) + 'detail'
		if of_window_is_open(ls_detail) then ls_windowname = ls_detail
	end if
	
	of_open_window(ls_windowname)
end if
end event

