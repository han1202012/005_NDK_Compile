#include <jni.h>
#include <android/log.h>

JNIEXPORT jstring JNICALL
Java_kim_hsl_compile_MainActivity_stringFromJNI(
        JNIEnv *env,
        jobject obj) {

    __android_log_print(ANDROID_LOG_INFO, "JNI_TAG", "Hello from C");

    return (*env)->NewStringUTF(env, "Hello from C");
}