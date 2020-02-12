
# my-dir 是 NDK 内置的函数 , 获取当前的目录路径
#	在该案例中就是 Android.mk 文件所在的目录的绝对路径 , 工程根目录/app/src/main/cpp
#	将该目录赋值给 LOCAL_PATH 变量
#	所有的 Android.mk 的第一行配置都是该语句

LOCAL_PATH := $(call my-dir)


# 打印 LOCAL_PATH 值
# Build 打印内容 : LOCAL_PATH : Y:/002_WorkSpace/001_AS/005_NDK_Compile/app/src/main/cpp
# 编译 APK 时会在 Build 中打印

$(info LOCAL_PATH : $(LOCAL_PATH))


# 配置新的模块之前都要先清除 LOCAL_XXX 变量
#	LOCAL_PATH 变量会保留

include $(CLEAR_VARS)


# 配置动态库名称
# 动态库命名规则 : 在 LOCAL_MODULE 基础上 , 添加 lib 前缀 和 .so 后缀
# 生成动态库名称 : libnative-lib.so

LOCAL_MODULE := native-lib


# 编译的源文件

LOCAL_SRC_FILES := native-lib.c


# 配置构建的目标是动态库

include $(BUILD_SHARED_LIBRARY)