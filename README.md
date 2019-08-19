#base image for chainnova devops

## 路径结构

```
baseimage
│   build_image.sh(编译主脚本)
└───dirs_list.sh
│   │   dir_list:要编译的镜像所在最外层文件夹
│   │   version_list：要编译的镜像路径下的版本路径
│   │   build_dir：编译上下文
│   └───registry_list：要推送的镜像仓库
│
└───xxxx (如fe_vue等)
│   │───x.x.x(版本号)
│   │   │   Dockerfile
│   │   └───Dockerfile-xxx
│   │
│   └───image_list.sh
│       │   image_names(镜像名称)
│       └───docker_files（对应的Dockerfile）
└───deployment(gitmodules，包含registry配置)
    
```

## 推送指令
修改dirs_list.sh中想要编译推送的镜像信息
```PUSH_IMAGE=true ./build_image.sh```