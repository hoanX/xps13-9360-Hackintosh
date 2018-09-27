## XPS 13-9360
```
基本配置:
cpu: i7-7560u
显卡：iris plus 640
ssd：PM961
网卡：DW1830
分辨率：3200x1800
当前安装系统版本：10.13.6(17G65) & 10.14（dp10）
```
> - 已知问题：sd读卡器无法使用(BIOS可以关闭，节省电量)
> - 安装好后，耳机无法使用的使用ALCPlugFix文件
> - 如果感觉网卡无线频段不够的可以在config中的Boot参数Arguments中添加`brcmfx-country=#a`,重启即可
> - 如果QHD分辨率设备，在开机第二阶段苹果logo变大，在config的Boot Graphics的UIScale中填入`2`，重启即可
> - 关于蓝牙问题，将蓝牙目录下BrcmFirmwareData.kext和BrcmPatchRAM2.kext驱动放入clover对应驱动目录即可，BT4LEContiunityFixup.kext是修复Handoff功能，我没有需求，没有添加，自行测试
> - （低频已不可用，效果不大，懒的制作新版本）~~kexts/cpu低频 文件夹可以使cpu多档变频以及低频支持（最低500）~~
>   - ~~以下二选一~~
>   - 1. ~~X86PlatformPluginInjector.kext安装到系统的L/E或者S/L/E文件夹下，重建缓存并重启（或者直接使用tools的工具，直接拖进去），目前添加i5-7200u,i7-7500u以及i7-7560u支持~~
>   - 2. ~~CPUFriend.kext和CPUFriendDataProvider.kext放到clover/kexts/other，重启即可（这个和上面那个效果一样，唯一区别就是这个可以不放到系统中，针对强迫症）~~
>  ```
>    重建缓存命令：
>    sudo kextcache -i /
>  ```

## 安装注意事项（很重要）：

---------------------

### 由于主板默认dvmt显存32M，所以FHD屏幕修改至少64M，QHD至少96M

#### 修改方法：

**方式一**（推荐）：此方法有风险，目前bios在2.3.1到2.6.2中参数可用，其它自行测试

使用DVMT目录下的DVMT.efi引导启动，0x785是DVMT Pre-allocation，首先命令 `setup_var 0x785` 回车，查看有无返回值，未修改是返回0x01(32M),如果没有返回值，切勿继续尝试以下操作。其它2个参数也是类似命令，查看有无返回值，无法返回值，切勿继续尝试以下操作

之后修改一下三个参数`0x4de`  `0x785` `0x786` ,命令分别为：

 `setup_var 0x4de 0x00 ` 

 `setup_var 0x785 0x06 `  :这里我直接设置到192M,FHD设置`setup_var 0x785 0x02 `即可 

 `setup_var 0x786 0x03 ` 

| Variable              | Offset | Default value  | Desired value   | Comment                                                    |
| --------------------- | ------ | -------------- | --------------- | ---------------------------------------------------------- |
| CFG Lock              | 0x4de  | 0x01 (Enabled) | 0x00 (Disabled) | Disable CFG Lock to prevent MSR 0x02 errors on boot        |
| DVMT Pre-allocation   | 0x785  | 0x01 (32M)     | 0x06 (192M)     | Increase DVMT pre-allocated size to 192M for QHD+ displays |
| DVMT Total Gfx Memory | 0x786  | 0x01 (128M)    | 0x03 (MAX)      | Increase total gfx memory limit to maximum                 |




**方式二**：使用WhateverGreen修复DVMT-Prealloc 32MB,（已添加到配置文件中，正常可以生效，不需要修改BIOS的dvmt，我没有测试过）

-----------------

### 2018-09-27（支持10.14）

- 更新触摸板驱动VoodooI2C到V2.14兼容10.14

### 2018-09-21（可能是最后一次更新10.13.6，等待10.14正式版）

- Clover版本更新到4674
- 使用[VirtualSMC](https://github.com/acidanthera/VirtualSMC)代替[FakeSMC](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek)
- 使用[WhateverGreen](https://github.com/acidanthera/WhateverGreen)方式驱动驱动显卡（依然是仿冒iris 540）
- 使用USBPower.kext替换[USB-Inject-All](https://bitbucket.org/RehabMan/os-x-usb-inject-all),同时去除SSDT-UIAC.aml（目前使用下来，蓝牙不像以前那样容易掉,有待观察）
- 更新[VoodooI2C](https://github.com/alexandred/VoodooI2C)版本到v2.1.1,支持所有原生触摸板手势（除了防误触外都很完美），驱动目前不兼容10.14，所以放在了kext/10.13中，10.14系统自行解决
- 更新驱动到最新版本

### 2018-09-06

- 更新最新版本Lilu和AppleAlc
- Fake id：iris 540（不影响性能），彻底解决有时候唤醒黑屏

### 2018-08-26

- 更新和精简驱动
- clover更新版本到v4658

### 2018-07-22

- 更新clover到r4618
- 更新smbios信息
- 更新部分hotpatch文件
- 更新lilu以及一波驱动，替换[IntelGraphicsFixup](https://github.com/lvs1974/IntelGraphicsFixup)和[Shiki](https://github.com/acidanthera/Shiki)为[WhateverGreen](https://github.com/acidanthera/WhateverGreen)

### 2018-06-07

- 尝试修复iris 640有时唤醒黑屏问题，参考[syscl](https://github.com/syscl/XPS9350-macOS)的iris 540补丁
- 更新smbios部分信息

### 2018-05-28

- Clover更新到4497
- 部分驱动更新到最新版本

### 2018-03-31

- 精简无用项
- 暂时移除蓝牙相关驱动,可能导致无法启动

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
