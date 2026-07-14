echo off
TITLE[请勿选中窗口，否则卡住无法进行，左上角出现选择字样卡住按回车恢复即可，OKAY代表成功，出现Failed说明线有问题或者电脑USB接口]
@ECHO OFF&setlocal enabledelayedexpansion&mode con lines=45 cols=119& color 0F

echo ---------------------------------------------------------------------------------------------------------------------
echo 设备名称           : Xiaomi 15 Pro
echo 酷安作者           : 江南烟雨断桥殇 
echo 联系作者           : QQ177059575 
echo 粉丝群             : 703747070 
echo ---------------------------------------------------------------------------------------------------------------------
echo.①刷机包需要完全全部解压出来并不是只解压一个文件解压变成文件夹才算解压成功。
echo.②刷机是个人行为，记得备份好数据，不备份数据丢失后果自负和作者无关，刷机有风险任何变砖等行为都由您个人承担。
echo.③手机需要进入FASTBOOT模式(音量- 和电源键)强烈建议使用原装数据线插入电脑否则无法识别或者刷入时报错报错导致手机黑砖。
echo.④出现-waiting for any device，请检查驱动(windows-driver内有驱动)是否用的原装充电线链接电脑手机进入fastboot模式。
echo.⑤确保你当前解压刷机包电脑磁盘有15G大小否则super转换失败。
echo ---------------------------------------------------------------------------------------------------------------------


if exist bin\windows\fastboot.exe PATH=%PATH%;bin\windows
if exist images\super.img.zst (
	echo.正在转换...
	zstd --rm -d images/super.img.zst -o images/super.img
	)
)
if exist bin\windows\fastboot.exe PATH=%PATH%;bin\windows

set /p wipeData="首次刷机选Y（自动清除全部数据）并回车，升级选N（保留数据）并回车（Y/N）"

echo.
echo 开始刷入系统底层文件

bin\windows\fastboot %* flash abl_ab images\abl.img
bin\windows\fastboot %* flash xbl_ab images\xbl.img
bin\windows\fastboot %* flash xbl_config_ab images\xbl_config.img
bin\windows\fastboot %* flash xbl_ramdump_ab images\xbl_ramdump.img
bin\windows\fastboot %* flash imagefv_ab images\imagefv.img
bin\windows\fastboot %* flash aop_ab images\aop.img
bin\windows\fastboot %* flash aop_config_ab images\aop_config.img
bin\windows\fastboot %* flash bluetooth_ab images\bluetooth.img
bin\windows\fastboot %* flash boot_ab images\boot.img
bin\windows\fastboot %* flash cpucp_ab images\cpucp.img
bin\windows\fastboot %* flash cpucp_dtb_ab images\cpucp_dtb.img
bin\windows\fastboot %* flash devcfg_ab images\devcfg.img
bin\windows\fastboot %* flash dsp_ab images\dsp.img
bin\windows\fastboot %* flash dtbo_ab images\dtbo.img
bin\windows\fastboot %* flash featenabler_ab images\featenabler.img
bin\windows\fastboot %* flash hyp_ab images\hyp.img
bin\windows\fastboot %* flash idmanager_ab images\idmanager.img
bin\windows\fastboot %* flash init_boot_ab images\init_boot.img
bin\windows\fastboot %* flash keymaster_ab images\keymaster.img
bin\windows\fastboot %* flash modem_ab images\modem.img
bin\windows\fastboot %* flash modemfirmware_ab images\modemfirmware.img
bin\windows\fastboot %* flash multiimgqti_ab images\multiimgqti.img
bin\windows\fastboot %* flash pdp_ab images\pdp.img
bin\windows\fastboot %* flash pdp_cdb_ab images\pdp_cdb.img
bin\windows\fastboot %* flash pvmfw_ab images\pvmfw.img
bin\windows\fastboot %* flash qupfw_ab images\qupfw.img
bin\windows\fastboot %* flash recovery_ab images\recovery.img
bin\windows\fastboot %* flash shrm_ab images\shrm.img
bin\windows\fastboot %* flash soccp_dcd_ab images\soccp_dcd.img
bin\windows\fastboot %* flash soccp_debug_ab images\soccp_debug.img
bin\windows\fastboot %* flash spuservice_ab images\spuservice.img
bin\windows\fastboot %* flash tz_ab images\tz.img
bin\windows\fastboot %* flash uefi_ab images\uefi.img
bin\windows\fastboot %* flash uefisecapp_ab images\uefisecapp.img
bin\windows\fastboot %* flash vbmeta_ab images\vbmeta.img
bin\windows\fastboot %* flash vbmeta_system_ab images\vbmeta_system.img
bin\windows\fastboot %* flash vendor_boot_ab images\vendor_boot.img
bin\windows\fastboot %* flash vm-bootsys_ab images\vm-bootsys.img
echo 开始刷入系统分区-快慢取决于电脑性能
bin\windows\fastboot %* erase super 
bin\windows\fastboot %* flash super images\super.img
echo 开始清除cust 报错failed为正常现象
bin\windows\fastboot %* flash cust images\cust.img
if /i "!wipeData!" == "y" (
	echo 正在格式化data分区 清除数据 若出现failed请将手机退出fastboot重新进入重新运行本bat重新刷入一次更换电脑USB接口尽量使用原装数据线-需要几分钟 
        bin\windows\fastboot %* erase userdata
        bin\windows\fastboot %* erase metadata
       bin\windows\fastboot %* erase frp
	echo.
	echo.
)
echo 准备自动重启，等待手机进入系统即可
bin\windows\fastboot %* set_active a
bin\windows\fastboot %* reboot
echo 详细注意事项请阅读酷安帖子!
echo.&echo 所有分区刷入完毕,任意键退出,若不开机，请删除刷机包重新解压 重新进行刷入！ & pause & exit

