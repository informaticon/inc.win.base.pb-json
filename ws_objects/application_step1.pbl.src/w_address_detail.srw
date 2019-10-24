$PBExportHeader$w_address_detail.srw
forward
global type w_address_detail from window
end type
type dw_detail from datawindow within w_address_detail
end type
end forward

global type w_address_detail from window
integer width = 4069
integer height = 1848
boolean titlebar = true
string title = "Address Detail"
boolean controlmenu = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = child!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
dw_detail dw_detail
end type
global w_address_detail w_address_detail

on w_address_detail.create
this.dw_detail=create dw_detail
this.Control[]={this.dw_detail}
end on

on w_address_detail.destroy
destroy(this.dw_detail)
end on

type dw_detail from datawindow within w_address_detail
integer x = 187
integer y = 180
integer width = 3282
integer height = 916
integer taborder = 10
string dataobject = "d_address_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

