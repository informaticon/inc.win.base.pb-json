$PBExportHeader$w_order.srw
forward
global type w_order from window
end type
type cb_1 from commandbutton within w_order
end type
type dw_detail from datawindow within w_order
end type
type st_3 from statictext within w_order
end type
type st_2 from statictext within w_order
end type
type dw_header from datawindow within w_order
end type
type st_1 from statictext within w_order
end type
type dw_list from datawindow within w_order
end type
end forward

global type w_order from window
integer width = 4037
integer height = 2868
boolean titlebar = true
string title = "Orders"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = child!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
cb_1 cb_1
dw_detail dw_detail
st_3 st_3
st_2 st_2
dw_header dw_header
st_1 st_1
dw_list dw_list
end type
global w_order w_order

type variables
u_data iu_data
end variables
on w_order.create
this.cb_1=create cb_1
this.dw_detail=create dw_detail
this.st_3=create st_3
this.st_2=create st_2
this.dw_header=create dw_header
this.st_1=create st_1
this.dw_list=create dw_list
this.Control[]={this.cb_1,&
this.dw_detail,&
this.st_3,&
this.st_2,&
this.dw_header,&
this.st_1,&
this.dw_list}
end on

on w_order.destroy
destroy(this.cb_1)
destroy(this.dw_detail)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_header)
destroy(this.st_1)
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

type cb_1 from commandbutton within w_order
integer x = 3456
integer y = 652
integer width = 357
integer height = 132
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "add"
end type

type dw_detail from datawindow within w_order
integer x = 1637
integer y = 804
integer width = 2245
integer height = 1808
integer taborder = 30
string title = "none"
string dataobject = "d_order_detail"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_order
integer x = 1627
integer y = 692
integer width = 727
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Order Details"
boolean focusrectangle = false
end type

type st_2 from statictext within w_order
integer x = 1618
integer y = 48
integer width = 727
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Order Header"
boolean focusrectangle = false
end type

type dw_header from datawindow within w_order
integer x = 1614
integer y = 160
integer width = 2277
integer height = 348
integer taborder = 20
string title = "none"
string dataobject = "d_order_header"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_order
integer x = 82
integer y = 56
integer width = 727
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Orders List"
boolean focusrectangle = false
end type

type dw_list from datawindow within w_order
integer x = 64
integer y = 152
integer width = 1417
integer height = 2536
integer taborder = 10
string title = "none"
string dataobject = "d_orders_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;selectrow(0, false)
selectrow(currentrow, true)

dw_header.scrolltorow(currentrow)

dw_detail.reset()
iu_data.of_fill_order_detail(dw_detail)
end event

