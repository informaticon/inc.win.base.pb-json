$PBExportHeader$w_address_list.srw
forward
global type w_address_list from window
end type
type cb_close from commandbutton within w_address_list
end type
type dw_list from datawindow within w_address_list
end type
type dw_search from datawindow within w_address_list
end type
end forward

global type w_address_list from window
boolean visible = false
integer width = 4718
integer height = 2620
boolean border = false
windowtype windowtype = child!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
dw_list dw_list
dw_search dw_search
end type
global w_address_list w_address_list

type variables
u_data iu_data
end variables

on w_address_list.create
this.cb_close=create cb_close
this.dw_list=create dw_list
this.dw_search=create dw_search
this.Control[]={this.cb_close,&
this.dw_list,&
this.dw_search}
end on

on w_address_list.destroy
destroy(this.cb_close)
destroy(this.dw_list)
destroy(this.dw_search)
end on

event open;long ll_i

iu_data = create u_data

dw_search.insertrow(1)

iu_data.of_fill_address(dw_list)
end event

event resize;dw_search.width = workspacewidth()
dw_list.width = workspacewidth()
dw_list.height = workspaceheight() - dw_list.y
cb_close.x = workspacewidth() - cb_close.width - 4
end event

event close;gw_main.of_close_window('w_address_list')
end event

type cb_close from commandbutton within w_address_list
integer x = 4576
integer y = 4
integer width = 142
integer height = 108
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "×"
end type

event clicked;close(parent)
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

lw_detail = gw_main.of_open_window('w_address_detail')

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

