
**CSDN 博客地址 :** [【Android NDK 开发】Android Studio 的 NDK 配置 ( 源码编译配置 | 构建脚本配置 | 打包配置 | CMake 配置 | ndkBuild 配置 )](https://hanshuliang.blog.csdn.net/article/details/104272170)

**博客资源下载地址 :** [https://download.csdn.net/download/han1202012/12152060](https://download.csdn.net/download/han1202012/12152060)

**示例代码 GitHub 地址 :** [https://github.com/han1202012/005_NDK_Compile](https://github.com/han1202012/005_NDK_Compile)

<br>

<br>
<br>

#### I . 源码编译配置

---

<br>

**1 . 源码编译配置 :** 

<br>

**① 配置位置 :** <font color=blue>Module 级别的 build.gradle 中进行配置 ; 

**② 主要作用 :** <font color=purple>主要作用是配置本工程中的 C/C++ 源码如何编译成动态库的 ; 

**③ 常用配置 :** <font color=green>一般配置将源码编译成哪几个 CPU 的指令集 ; 

<font color=orange> 目前只支持 <font color=black>**armeabi-v7a** , **arm64-v8a** , **x86** , **x86-64** <font color=orange>四种 CPU 指令集架构 ; 



<br>

**2 . 配置层级 :** <font color=red>在 android 下 defaultConfig 中配置的 externalNativeBuild 是配置 AS 中的 C/C++ 源码编译内容的 ; 

<br>

**注意区分配置 :** <font color=blue>externalNativeBuild 有两种类型的配置 , 一种在 defaultConfig 内部 , 一种在 defaultConfig 外部  ; 

<br>

**① defaultConfig 内部的 externalNativeBuild :** <font color=green>配置的是配置 AS 工程的 C/C++ 源文件编译参数

**② defaultConfig 外部的 externalNativeBuild :** <font color=purple>配置的是 CMakeList.txt 或 Android.mk 构建脚本的路径


<br>

**2 . 配置脚本示例 ( 省略无关内容 ) :** 

```java
apply plugin: 'com.android.application'

android {
    ...
    defaultConfig {
        ...
        /*
            关于 CPU 指令集

            NDK 17 以上只支持 armeabi-v7a, arm64-v8a, x86, x86-64 四种 CPU 架构
         */
        
        // 配置 AS 工程中的 C/C++ 源文件的编译
        //     defaultConfig 内部的 externalNativeBuild 配置的是配置 AS 工程的 C/C++ 源文件编译参数
        //     defaultConfig 外部的 externalNativeBuild 配置的是 CMakeList.txt 或 Android.mk 构建脚本的路径
        externalNativeBuild {
            cmake {
                cppFlags ""

                //配置编译 C/C++ 源文件为哪几个 CPU 指令集的函数库 (arm , x86 等)
                abiFilters "armeabi-v7a" , "arm64-v8a", "x86", "x86_64"
            }
        }
		...
    }
	...
}
```


<br>
<br>

#### II . 构建脚本配置

---

<br>


**1 . 构建脚本配置 :** 

<br>

**① 配置位置 :** <font color=blue>Module 级别的 build.gradle 中进行配置 ; 

**② 主要作用 :** <font color=purple>主要作用是配置本工程中的 C/C++ 源码的构建脚本 ; 

**③ 常用配置 :** <font color=green>配置 cmake 或 ndkBuild 两种编译脚本中的一种 ( 只能二选一 ) ; 

<br>

**2 . cmake 配置 :** <font color=blue>配置使用 CMake 编译 C/C++ 时的构建脚本 **CMakeList.txt** 路径 ; 

<br>

**① cmake 简介 :** <font color=orange>使用 CMake 进行构建 , 构建脚本是 CMakeList.txt , 是 Android Studio 中新引入的 NDK 本地代码构建方式 ; 


**② 路径设置 :** <font color=purple>路径的起点就是 build.gradle 文件所在的目录 , 即 **app** 目录 ; 


**② 配置示例 :** 

```java
    externalNativeBuild {
        cmake {
            path "src/main/cpp/CMakeLists.txt"
            version "3.10.2"
        }
```

<br>

**3 . ndkBuild 配置 :** <font color=blue>配置使用 ndkBuild 编译 C/C++ 时的构建脚本 **Android.mk** 路径 ; 

<br>

**① ndkBuild 简介 :** <font color=orange>使用 ndkBuild 进行构建 , 构建脚本是 Android.mk , 是从 Eclipse + ADT 环境遗留下来的配置 NDK 编译方案 , 逐步被 CMake 替代 ; 


**② 路径设置 :** <font color=purple>路径的起点就是 build.gradle 文件所在的目录 , 即 **app** 目录 ; 


**② 配置示例 :** 

```java
    externalNativeBuild {
        ndkBuild{
            path "src/main/cpp/Android.mk"
        }
```


<br>

**3 . 配置层级 :** <font color=red>在 android 与 defaultConfig 平级的 externalNativeBuild 是配置 AS 中的 C/C++ 源码编译构建脚本的 ; 

<br>

**注意区分配置 :** <font color=blue>externalNativeBuild 有两种类型的配置 , 一种在 defaultConfig 内部 , 一种在 defaultConfig 外部与之平级的配置  ; 

<br>

**① defaultConfig 内部的 externalNativeBuild :** <font color=green>配置的是配置 AS 工程的 C/C++ 源文件编译参数

**② defaultConfig 外部的 externalNativeBuild :** <font color=purple>配置的是 CMakeList.txt 或 Android.mk 构建脚本的路径


<br>

**4 . 配置脚本示例 ( 省略无关内容 ) :** 

```java
apply plugin: 'com.android.application'

android {
    ...
    defaultConfig {
        ...
    }
    // 配置 NDK 的编译脚本路径
    // 编译脚本有两种 ① CMakeList.txt ② Android.mk
    //     defaultConfig 内部的 externalNativeBuild 配置的是配置 AS 工程的 C/C++ 源文件编译参数
    //     defaultConfig 外部的 externalNativeBuild 配置的是 CMakeList.txt 或 Android.mk 构建脚本的路径
    externalNativeBuild {

        // 配置 CMake 构建脚本 CMakeLists.txt 脚本路径
        //  使用该配置时 , 将 ndkBuild 配置注释掉
        cmake {
            path "src/main/cpp/CMakeLists.txt"
            version "3.10.2"
        }

        // 配置 Android.mk 构建脚本路径
        //  使用该配置时 , 将 cmake 配置注释掉
        /*ndkBuild{
            path "src/main/cpp/Android.mk"
        }*/
    }
	...
}
...
```

<br>
<br>

#### III . NDK 函数库打包配置

---

<br>

**1 . 构建脚本配置 :** 

<br>

**① 配置位置 :** <font color=blue>Module 级别的 build.gradle 中进行配置 ; 

**② 主要作用 :** <font color=purple>主要作用是配置 APK 打包动态库的相关参数 ; 如在工程中编译的函数库 , 其提供了 arm, x86, mips 等指令集的动态库 , 那么为了控制打包后的应用大小, 可以选择性打包一些库 , 此处就是进行该配置 ; 

**③ 常用配置 :** <font color=green>配置 cmake 或 ndkBuild 两种编译脚本中的一种 ( 只能二选一 ) ; 

<br>

**2 . 配置脚本示例 ( 省略无关内容 ) :** 

```java
apply plugin: 'com.android.application'

android {
    ...
    defaultConfig {
        ...
        /*
            关于 CPU 指令集

            NDK 17 以上只支持 armeabi-v7a, arm64-v8a, x86, x86-64 四种 CPU 架构
         */
        //配置 APK 打包 哪些动态库
        //  示例 : 如在工程中编译的函数库 , 其提供了 arm, x86, mips 等指令集的动态库
        //        那么为了控制打包后的应用大小, 可以选择性打包一些库 , 此处就是进行该配置
        ndk{
            // 打包生成的 APK 文件指挥包含 ARM 指令集的动态库
            abiFilters "armeabi-v7a" , "arm64-v8a", "x86", "x86_64"
        }
		...
    }
	...
}
```


<br>
<br>

#### IV . Java 与 C 代码示例

---

<br>

**1 . Java 代码 :** 

```java
package kim.hsl.compile;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    static {
        //此处只能加载动态库 , 不能加载静态库
        System.loadLibrary("native-lib");
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        TextView tv = findViewById(R.id.sample_text);
        tv.setText(stringFromJNI());

    }

    public native String stringFromJNI();

}

```

<br>

**2 . C 代码 :** 

```c
#include <jni.h>
#include <android/log.h>

JNIEXPORT jstring JNICALL
Java_kim_hsl_compile_MainActivity_stringFromJNI(
        JNIEnv *env,
        jobject obj) {

    __android_log_print(ANDROID_LOG_INFO, "JNI_TAG", "Hello from C");

    return (*env)->NewStringUTF(env, "Hello from C");
}
```





<br>
<br>

#### V . CMake 配置 ( CMakeLists.txt )

---

<br>

**1 . CMakeLists.txt 配置示例 :** 

```shell

# 声明 CMake 版本
cmake_minimum_required(VERSION 3.4.1)

# 添加库
add_library( # Sets the name of the library.
        native-lib

        # Sets the library as a shared library.
        SHARED

        # Provides a relative path to your source file(s).
        native-lib.c)


# 到预设的目录查找 log 库 , 将找到的路径赋值给 log-lib
#   这个路径是 NDK 的 ndk-bundle\platforms\android-29\arch-arm\usr\lib\liblog.so
#   不同的 Android 版本号 和 CPU 架构 需要到对应的目录中查找 , 此处是 29 版本 32 位 ARM 架构的日志库
find_library(
        log-lib

        log)

# 链接库
target_link_libraries(
        native-lib

        ${log-lib})
```

<br>

**2 . 对应的 build.gradle 中的 NDK 配置 :**

```java
apply plugin: 'com.android.application'

android {
    ...
        /*
            关于 CPU 指令集

            NDK 17 以上只支持 armeabi-v7a, arm64-v8a, x86, x86-64 四种 CPU 指令集架构
         */

        // 配置 AS 工程中的 C/C++ 源文件的编译
        //     defaultConfig 内部的 externalNativeBuild 配置的是配置 AS 工程的 C/C++ 源文件编译参数
        //     defaultConfig 外部的 externalNativeBuild 配置的是 CMakeList.txt 或 Android.mk 构建脚本的路径
        externalNativeBuild {
            cmake {
                cppFlags ""

                //配置编译 C/C++ 源文件为哪几个 CPU 指令集的函数库 (arm , x86 等)
                abiFilters "armeabi-v7a" , "arm64-v8a", "x86", "x86_64"
            }
        }


        //配置 APK 打包 哪些动态库
        //  示例 : 如在工程中编译的函数库 , 其提供了 arm, x86, mips 等指令集的动态库
        //        那么为了控制打包后的应用大小, 可以选择性打包一些库 , 此处就是进行该配置
        ndk{
            // 打包生成的 APK 文件指挥包含 ARM 指令集的动态库
            abiFilters "armeabi-v7a" , "arm64-v8a", "x86", "x86_64"
        }


    }

    // 配置 NDK 的编译脚本路径
    // 编译脚本有两种 ① CMakeList.txt ② Android.mk
    //     defaultConfig 内部的 externalNativeBuild 配置的是配置 AS 工程的 C/C++ 源文件编译参数
    //     defaultConfig 外部的 externalNativeBuild 配置的是 CMakeList.txt 或 Android.mk 构建脚本的路径
    externalNativeBuild {

        // 配置 CMake 构建脚本 CMakeLists.txt 脚本路径
        //  使用该配置时 , 将 ndkBuild 配置注释掉
        cmake {
            path "src/main/cpp/CMakeLists.txt"
            version "3.10.2"
        }

        // 配置 Android.mk 构建脚本路径
        //  使用该配置时 , 将 cmake 配置注释掉
        /*ndkBuild{
            path "src/main/cpp/Android.mk"
        }*/
    }
	...
}
...
```


<br>
<br>

#### VI . ndkBuild 配置 ( Android.mk )

---

<br>

**1 . Android.mk 配置示例 :** 

```shell

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
```

<br>


**2 . 对应的 build.gradle 中的 NDK 配置 :**

```java
apply plugin: 'com.android.application'

android {
    ...
        /*
            关于 CPU 指令集

            NDK 17 以上只支持 armeabi-v7a, arm64-v8a, x86, x86-64 四种 CPU 指令集架构
         */

        // 配置 AS 工程中的 C/C++ 源文件的编译
        //     defaultConfig 内部的 externalNativeBuild 配置的是配置 AS 工程的 C/C++ 源文件编译参数
        //     defaultConfig 外部的 externalNativeBuild 配置的是 CMakeList.txt 或 Android.mk 构建脚本的路径
        externalNativeBuild {
            cmake {
                cppFlags ""

                //配置编译 C/C++ 源文件为哪几个 CPU 指令集的函数库 (arm , x86 等)
                abiFilters "armeabi-v7a" , "arm64-v8a", "x86", "x86_64"
            }
        }


        //配置 APK 打包 哪些动态库
        //  示例 : 如在工程中编译的函数库 , 其提供了 arm, x86, mips 等指令集的动态库
        //        那么为了控制打包后的应用大小, 可以选择性打包一些库 , 此处就是进行该配置
        ndk{
            // 打包生成的 APK 文件指挥包含 ARM 指令集的动态库
            abiFilters "armeabi-v7a" , "arm64-v8a", "x86", "x86_64"
        }


    }

    // 配置 NDK 的编译脚本路径
    // 编译脚本有两种 ① CMakeList.txt ② Android.mk
    //     defaultConfig 内部的 externalNativeBuild 配置的是配置 AS 工程的 C/C++ 源文件编译参数
    //     defaultConfig 外部的 externalNativeBuild 配置的是 CMakeList.txt 或 Android.mk 构建脚本的路径
    externalNativeBuild {

        // 配置 CMake 构建脚本 CMakeLists.txt 脚本路径
        //  使用该配置时 , 将 ndkBuild 配置注释掉
        /*cmake {
            path "src/main/cpp/CMakeLists.txt"
            version "3.10.2"
        }*/

        // 配置 Android.mk 构建脚本路径
        //  使用该配置时 , 将 cmake 配置注释掉
        ndkBuild{
            path "src/main/cpp/Android.mk"
        }
    }
	...
}
...
```


<br>
<br>

#### VII . 博客相关资源下载

---

<br>

**CSDN 博客地址 :** [【Android NDK 开发】Android Studio 的 NDK 配置 ( 源码编译配置 | 构建脚本配置 | 打包配置 | CMake 配置 | ndkBuild 配置 )](https://hanshuliang.blog.csdn.net/article/details/104272170)

**博客资源下载地址 :** [https://download.csdn.net/download/han1202012/12152060](https://download.csdn.net/download/han1202012/12152060)

**示例代码 GitHub 地址 :** [https://github.com/han1202012/005_NDK_Compile](https://github.com/han1202012/005_NDK_Compile)
