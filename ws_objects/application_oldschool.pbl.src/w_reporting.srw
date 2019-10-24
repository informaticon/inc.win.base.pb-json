$PBExportHeader$w_reporting.srw
forward
global type w_reporting from window
end type
type cb_2 from commandbutton within w_reporting
end type
type cb_1 from commandbutton within w_reporting
end type
type tab_reporting from tab within w_reporting
end type
type tabpage_address from userobject within tab_reporting
end type
type dw_address from datawindow within tabpage_address
end type
type tabpage_address from userobject within tab_reporting
dw_address dw_address
end type
type tabpage_article from userobject within tab_reporting
end type
type dw_article from datawindow within tabpage_article
end type
type tabpage_article from userobject within tab_reporting
dw_article dw_article
end type
type tab_reporting from tab within w_reporting
tabpage_address tabpage_address
tabpage_article tabpage_article
end type
end forward

global type w_reporting from window
integer width = 4114
integer height = 2436
boolean titlebar = true
string title = "Reporting"
boolean controlmenu = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = child!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
cb_2 cb_2
cb_1 cb_1
tab_reporting tab_reporting
end type
global w_reporting w_reporting

type variables
u_data iu_data
end variables
on w_reporting.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.tab_reporting=create tab_reporting
this.Control[]={this.cb_2,&
this.cb_1,&
this.tab_reporting}
end on

on w_reporting.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.tab_reporting)
end on

event open;iu_data = create u_data

iu_data.of_fill_address(tab_reporting.tabpage_address.dw_address)

tab_reporting.tabpage_address.dw_address.object.datawindow.print.preview='yes'

iu_data.of_fill_article(tab_reporting.tabpage_article.dw_article)

tab_reporting.tabpage_article.dw_article.object.datawindow.print.preview='yes'
end event

type cb_2 from commandbutton within w_reporting
integer x = 2926
integer y = 24
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reload"
end type

type cb_1 from commandbutton within w_reporting
integer x = 3433
integer y = 24
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Print"
end type

type tab_reporting from tab within w_reporting
integer x = 119
integer y = 196
integer width = 3703
integer height = 2080
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_address tabpage_address
tabpage_article tabpage_article
end type

on tab_reporting.create
this.tabpage_address=create tabpage_address
this.tabpage_article=create tabpage_article
this.Control[]={this.tabpage_address,&
this.tabpage_article}
end on

on tab_reporting.destroy
destroy(this.tabpage_address)
destroy(this.tabpage_article)
end on

type tabpage_address from userobject within tab_reporting
integer x = 18
integer y = 112
integer width = 3666
integer height = 1952
long backcolor = 67108864
string text = "Address"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_address dw_address
end type

on tabpage_address.create
this.dw_address=create dw_address
this.Control[]={this.dw_address}
end on

on tabpage_address.destroy
destroy(this.dw_address)
end on

type dw_address from datawindow within tabpage_address
integer x = 59
integer y = 40
integer width = 3515
integer height = 1868
integer taborder = 20
string title = "none"
string dataobject = "d_address_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_article from userobject within tab_reporting
integer x = 18
integer y = 112
integer width = 3666
integer height = 1952
long backcolor = 67108864
string text = "Article"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_article dw_article
end type

on tabpage_article.create
this.dw_article=create dw_article
this.Control[]={this.dw_article}
end on

on tabpage_article.destroy
destroy(this.dw_article)
end on

type dw_article from datawindow within tabpage_article
integer x = 37
integer y = 32
integer width = 3575
integer height = 1888
integer taborder = 20
string title = "none"
string dataobject = "d_article_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

