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
