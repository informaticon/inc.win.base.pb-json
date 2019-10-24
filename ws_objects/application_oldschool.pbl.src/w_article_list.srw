$PBExportHeader$w_article_list.srw
forward
global type w_article_list from window
end type
type dw_list from datawindow within w_article_list
end type
type dw_search from datawindow within w_article_list
end type
end forward

global type w_article_list from window
integer width = 4773
integer height = 2740
boolean titlebar = true
string title = "Article List"
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
global w_article_list w_article_list

type variables
u_data iu_data
end variables

on w_article_list.create
this.dw_list=create dw_list
this.dw_search=create dw_search
this.Control[]={this.dw_list,&
this.dw_search}
end on

on w_article_list.destroy
destroy(this.dw_list)
destroy(this.dw_search)
end on

event open;iu_data = create u_data

dw_search.insertrow(1)

iu_data.of_fill_article(dw_list)
end event

type dw_list from datawindow within w_article_list
integer x = 347
integer y = 416
integer width = 3630
integer height = 2052
integer taborder = 20
string title = "none"
string dataobject = "d_article_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;selectrow(0, false)
selectrow(currentrow, true)
end event

event doubleclicked;w_article_detail lw_detail

opensheet(lw_detail, w_main, 3, original!)
dw_list.sharedata(lw_detail.dw_detail)
lw_detail.dw_detail.scrolltorow(row)
end event

type dw_search from datawindow within w_article_list
integer x = 151
integer y = 76
integer width = 3959
integer height = 252
integer taborder = 10
string title = "none"
string dataobject = "d_address_search"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

