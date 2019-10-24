$PBExportHeader$w_order.srw
forward
global type w_order from window
end type
type dw_detail from datawindow within w_order
end type
type dw_header from datawindow within w_order
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
dw_detail dw_detail
dw_header dw_header
dw_list dw_list
end type
global w_order w_order

type variables
u_data iu_data
end variables

on w_order.create
this.dw_detail=create dw_detail
this.dw_header=create dw_header
this.dw_list=create dw_list
this.Control[]={this.dw_detail,&
this.dw_header,&
this.dw_list}
end on

on w_order.destroy
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
borderstyle borderstyle = StyleBox!
end type

type dw_header from datawindow within w_order
integer x = 1554
integer width = 2423
integer height = 432
integer taborder = 20
string title = "none"
string dataobject = "d_order_header"
boolean livescroll = true
borderstyle borderstyle = StyleBox!
end type

type dw_list from datawindow within w_order
integer width = 1559
integer height = 2752
integer taborder = 10
string title = "none"
string dataobject = "d_orders_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = StyleBox!
end type

event rowfocuschanged;selectrow(0, false)
selectrow(currentrow, true)

dw_header.scrolltorow(currentrow)

dw_detail.reset()
iu_data.of_fill_order_detail(dw_detail)
end event

