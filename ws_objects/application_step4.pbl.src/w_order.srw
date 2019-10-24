$PBExportHeader$w_order.srw
forward
global type w_order from window
end type
type cb_close from commandbutton within w_order
end type
type dw_detail from datawindow within w_order
end type
type dw_header from datawindow within w_order
end type
type dw_list from datawindow within w_order
end type
end forward

global type w_order from window
boolean visible = false
integer width = 4069
integer height = 2748
boolean border = false
windowtype windowtype = child!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
dw_detail dw_detail
dw_header dw_header
dw_list dw_list
end type
global w_order w_order

type variables
u_data iu_data
end variables

on w_order.create
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.dw_header=create dw_header
this.dw_list=create dw_list
this.Control[]={this.cb_close,&
this.dw_detail,&
this.dw_header,&
this.dw_list}
end on

on w_order.destroy
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.dw_header)
destroy(this.dw_list)
end on

event open;long ll_i
datawindowchild ldwc


iu_data = create u_data

dw_header.getchild('address', ldwc)
iu_data.of_fill_address(ldwc)
dw_list.getchild('address', ldwc)
iu_data.of_fill_address(ldwc)
dw_detail.getchild('article', ldwc)
iu_data.of_fill_article(ldwc)

iu_data.of_fill_order(dw_list)

dw_list.sharedata(dw_header)


end event

event resize;dw_list.height = workspaceheight()
dw_header.width = workspacewidth() - dw_header.x
dw_detail.width = workspacewidth() - dw_detail.x
dw_detail.height = workspaceheight() - dw_detail.y

cb_close.x = workspacewidth() - cb_close.width - 4
end event

event close;gw_main.of_close_window('w_order')
end event

type cb_close from commandbutton within w_order
integer x = 2002
integer y = 4
integer width = 142
integer height = 108
integer taborder = 30
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

type dw_detail from datawindow within w_order
integer x = 1554
integer y = 428
integer width = 2441
integer height = 2332
integer taborder = 30
string title = "none"
string dataobject = "d_order_detail"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_header from datawindow within w_order
integer x = 1554
integer width = 2427
integer height = 432
integer taborder = 20
string title = "none"
string dataobject = "d_order_header"
boolean livescroll = true
end type

type dw_list from datawindow within w_order
integer width = 1559
integer height = 2752
integer taborder = 10
string title = "none"
string dataobject = "d_orders_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;selectrow(0, false)
selectrow(currentrow, true)

dw_header.scrolltorow(currentrow)

dw_detail.reset()
iu_data.of_fill_order_detail(dw_detail)
end event

