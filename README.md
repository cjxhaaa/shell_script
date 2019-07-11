# shell_script
shell脚本

mod_host.sh
传入替换文件的路径，会自动修改本机上/etc/hosts。做到了完美的去重和替换

使用方式
```
chmod +x mod_host.sh
./mod_host.sh <new_hosts path>
```

应用场景举例：
在容器中，new_hosts可以把宿主机的/etc/hosts mount进来，即指定宿主机的hosts，即可修改容器内的hosts。

可以起一个定时任务，动态的修改容器hosts。

new_hosts的正则匹配模式可根据需要自行修改arrs=($(awk '/([0-9]{1,3}\.){3}[0-9]{1,3}.*#.*\[/ {print $1,$2}' $1))此行代码
