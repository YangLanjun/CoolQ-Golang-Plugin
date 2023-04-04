package main

import "github.com/YangLanjun/CoolQ-Golang-SDK/cqp"

//go:generate cqcfg -c .
func main() { /*此处应当留空*/ }

func init() {
	cqp.AppID = "dr.me.demo" // TODO: 修改为这个插件的ID
	cqp.PrivateMsg = onPrivateMsg
}

func onPrivateMsg(subType, msgID int32, fromQQ int64, msg string, font int32) int32 {
	cqp.SendPrivateMsg(fromQQ, msg) //复读机
	return 0
}
