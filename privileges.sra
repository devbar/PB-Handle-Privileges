HA$PBExportHeader$privileges.sra
$PBExportComments$Generated Application Object
forward
global type privileges from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type privileges from application
string appname = "privileges"
end type
global privileges privileges

on privileges.create
appname="privileges"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on privileges.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open (w_main)
end event

