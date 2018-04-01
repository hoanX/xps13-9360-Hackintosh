## XPS 13-9360
```
基本配置:
   cpu: i7-7560u
   显卡：iris plus 640
   ssd：pm961
   网卡：dw1560（bcm94352z）
   分辨率：3200x1800
```
> - 已知问题：sd读卡器无法使用，触摸板无法支持缩放旋转手势，其它正常
> - 安装好后，耳机无法使用的使用ALCPlugFix文件
> - LE文件夹可以使cpu多档变频以及低频支持（最低600，虽然设置最低400），变频有16档左右（具体忘记了），安装到系统的L/E文件夹下，重建缓存并重启，也就是hwp，仅i7-7560u使用
>  ```
>    重建缓存命令：
>    sudo kextcache -i /
>  ```

## 安装注意事项（很重要）：

---------------------

### 由于主板默认dvmt显存32M，所以FHD屏幕修改至少64M，QHD至少96M

#### 修改方法：

**方式一**（推荐）：此方法有风险，目前bios在2.3.1到2.6.2中参数可用，其它自行测试

使用DVMT目录下的DVMT.efi引导启动，0x785是DVMT Pre-allocation，首先命令 `setup_var 0x785` 回车，查看有无返回值，未修改是返回0x01(32M),如果没有返回值，切勿继续尝试以下操作

之后修改一下三个参数`0x4de`  `0x785` `0x786` ,命令分别为：

 `setup_var 0x4de 0x00 ` 

 `setup_var 0x785 0x06 `  :这里我直接设置到192M

 `setup_var 0x486 0x03 ` 

| Variable              | Offset | Default value  | Desired value   | Comment                                                    |
| --------------------- | ------ | -------------- | --------------- | ---------------------------------------------------------- |
| CFG Lock              | 0x4de  | 0x01 (Enabled) | 0x00 (Disabled) | Disable CFG Lock to prevent MSR 0x02 errors on boot        |
| DVMT Pre-allocation   | 0x785  | 0x01 (32M)     | 0x06 (192M)     | Increase DVMT pre-allocated size to 192M for QHD+ displays |
| DVMT Total Gfx Memory | 0x786  | 0x01 (128M)    | 0x03 (MAX)      | Increase total gfx memory limit to maximum                 |



方法二：将DVMT下的IntelGraphicsDVMTFixup.kext驱动放到clover/kexts/other下，有时候可能不起作用

-----------------

### 2018-03-31

- 精简无用项
- 暂时移除蓝牙相关驱动
- 小改config配置

### 2018-03-17

- 更新clover到4418
- 雷电3可以热插拔了
- 触摸板替换为VoodooI2C，使用更加灵敏
- Applealc，IntelGraphicsFixup，Lilu驱动版本更新
- 关于无用启动引导也好了，clover configurator版本问题，导致配置有问题


### 2018-01-24

- 更新clover到4380
- 更新hotpatch文件，无需注入显卡id，自动识别，同样也支持其它cpu
- 更新AppleALC最新release版
- 加入shiki.kext驱动，修复itunes 无故退出
- 更新主题Kuke
- clover界面多了很多无用的启动项，不知道为什么无法屏蔽！！！

## Credit
[the-darkvoid](https://github.com/the-darkvoid/XPS9360-macOS)
