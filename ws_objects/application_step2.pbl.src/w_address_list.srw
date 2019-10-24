$PBExportHeader$w_address_list.srw
forward
global type w_address_list from window
end type
type dw_list from datawindow within w_address_list
end type
type dw_search from datawindow within w_address_list
end type
end forward

global type w_address_list from window
integer width = 4773
integer height = 2740
boolean titlebar = true
string title = "Address List"
boolean controlmenu = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = child!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
dw_list dw_list
dw_search dw_search
end type
global w_address_list w_address_list

type variables
u_data iu_data
end variables

on w_address_list.create
this.dw_list=create dw_list
this.dw_search=create dw_search
this.Control[]={this.dw_list,&
this.dw_search}
end on

on w_address_list.destroy
destroy(this.dw_list)
destroy(this.dw_search)
end on

event open;long ll_i

iu_data = create u_data

dw_search.insertrow(1)

iu_data.of_fill_address(dw_list)
end event

type dw_list from datawindow within w_address_list
integer y = 380
integer width = 4736
integer height = 2244
integer taborder = 20
string title = "none"
string dataobject = "d_address_list"
boolean livescroll = true
end type

event rowfocuschanged;selectrow(0, false)
selectrow(currentrow, true)
end event

event doubleclicked;w_address_detail lw_detail

opensheet(lw_detail, w_main, 3, original!)
dw_list.sharedata(lw_detail.dw_detail)
lw_detail.dw_detail.scrolltorow(row)
end event

type dw_search from datawindow within w_address_list
integer width = 4722
integer height = 384
integer taborder = 10
string title = "none"
string dataobject = "d_address_search"
boolean livescroll = true
end type

